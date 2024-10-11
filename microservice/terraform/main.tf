resource "google_compute_network" "vpc_network" {
  name                    = var.vpc_name
  auto_create_subnetworks = false  # Deshabilitamos la creación automática de subredes
}

resource "google_compute_subnetwork" "gke_subnet" {
  name          = var.subnet_name
  ip_cidr_range = "10.0.0.0/20"  # Rango de IPs para la subred
  network       = google_compute_network.vpc_network.id  # Referencia a la VPC creada previamente
  region        = var.region  # Usa la región del clúster
}

resource "google_container_cluster" "primary" {
  name     = var.cluster_name
  location = var.region

  # Conectar el clúster a la VPC y subred personalizada
  network    = google_compute_network.vpc_network.id
  subnetwork = google_compute_subnetwork.gke_subnet.id

  # Configurar clúster con IPs privadas
  private_cluster_config {
    enable_private_nodes    = true
    master_ipv4_cidr_block  = "172.16.0.0/28"  # Rango de IP del master (ajustado)
    enable_private_endpoint = false
  }

  initial_node_count = 1  # Asegúrate de que sea mayor que 0

  remove_default_node_pool = true

  # Servicios de Logging y Monitoring
  logging_service    = "logging.googleapis.com/kubernetes"
  monitoring_service = "monitoring.googleapis.com/kubernetes"

  # Política de asignación de IPs
  ip_allocation_policy {
    cluster_ipv4_cidr_block  = "10.96.0.0/14"  # CIDR para los pods
    services_ipv4_cidr_block = "10.100.0.0/20" # CIDR para los servicios
  }

  deletion_protection = false
}

resource "google_container_node_pool" "primary_nodes" {
  cluster  = google_container_cluster.primary.name
  location = google_container_cluster.primary.location

  # Pool de nodos inicial
  initial_node_count = var.min_node_count

  node_config {
    machine_type = var.machine_type
    disk_size_gb = 50
    disk_type    = "pd-standard"
    oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]
  }

  autoscaling {
    min_node_count = var.min_node_count
    max_node_count = var.max_node_count
  }
}

# Crear un router para manejar el tráfico NAT
resource "google_compute_router" "nat_router" {
  name    = var.nat_router
  network = google_compute_network.vpc_network.name
  region  = var.region
}

# Configurar Cloud NAT para que los nodos del clúster puedan salir a internet
resource "google_compute_router_nat" "nat_config" {
  name     = var.nat_config
  router   = google_compute_router.nat_router.name
  region   = var.region

  nat_ips = []  # Deja vacío para que Google Cloud asigne las IPs automáticamente

  nat_ip_allocate_option = "AUTO_ONLY"  # Automáticamente asigna IPs

  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
  min_ports_per_vm = 1024
}

resource "google_compute_firewall" "allow_http_outbound" {
  name    = "allow-http-outbound-gke-loadtester"
  network = google_compute_network.vpc_network.name

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  direction = "EGRESS"
  target_tags = ["gke-nodes"]
  priority = 1000
  description = "Permitir tráfico HTTP de salida desde los nodos de GKE"
}
