resource "google_compute_network" "vpc_network" {
  name                    = var.vpc_name
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "gke_subnet" {
  name          = var.subnet_name
  ip_cidr_range = "10.0.0.0/20"
  network       = google_compute_network.vpc_network.id
  region        = var.region
}

resource "google_container_cluster" "primary" {
  name     = var.cluster_name
  location = var.region

  network    = google_compute_network.vpc_network.id
  subnetwork = google_compute_subnetwork.gke_subnet.id

  node_config {
    disk_size_gb = 10
    disk_type    = "pd-standard"
  }

  private_cluster_config {
    enable_private_nodes    = true
    master_ipv4_cidr_block  = "172.16.0.0/28"
    enable_private_endpoint = false
  }

  initial_node_count = 1  # Asegúrate de que sea mayor que 0

  remove_default_node_pool = true

  logging_service    = "logging.googleapis.com/kubernetes"
  monitoring_service = "monitoring.googleapis.com/kubernetes"

  ip_allocation_policy {
    cluster_ipv4_cidr_block  = "10.96.0.0/14"  # CIDR para los pods
    services_ipv4_cidr_block = "10.100.0.0/20" # CIDR para los servicios
  }

  deletion_protection = false
}

resource "google_container_node_pool" "primary_nodes" {
  cluster  = google_container_cluster.primary.name
  location = google_container_cluster.primary.location

  initial_node_count = var.min_node_count

  node_config {
    machine_type = var.machine_type
    disk_size_gb = 10
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

resource "google_compute_router" "nat_router" {
  name    = var.nat_router
  network = google_compute_network.vpc_network.name
  region  = var.region
}

resource "google_compute_router_nat" "nat_config" {
  name     = var.nat_config
  router   = google_compute_router.nat_router.name
  region   = var.region

  nat_ips = []

  nat_ip_allocate_option = "AUTO_ONLY"

  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
  min_ports_per_vm = 1024
}

# Permitir el tráfico interno entre nodos y Pods en el clúster
resource "google_compute_firewall" "allow_internal_traffic" {
  name    = "allow-internal-traffic"
  network = google_compute_network.vpc_network.name

  allow {
    protocol = "tcp"
    ports    = ["0-65535"]
  }

  allow {
    protocol = "udp"
    ports    = ["0-65535"]
  }

  source_ranges = ["10.0.0.0/20"]  # Rango de IP de tu subred privada
}

# Permitir el tráfico saliente hacia el NAT Gateway para acceso a Internet
resource "google_compute_firewall" "allow_nat_traffic" {
  name    = "allow-nat-traffic"
  network = google_compute_network.vpc_network.name

  allow {
    protocol = "tcp"
    ports    = ["0-65535"]
  }

  allow {
    protocol = "udp"
    ports    = ["0-65535"]
  }

  source_ranges = ["10.0.0.0/20"]  # Rango de IP de la subred
}

# Permitir acceso a la API de Kubernetes (API Server)
resource "google_compute_firewall" "allow_api_server" {
  name    = "allow-k8s-api-server"
  network = google_compute_network.vpc_network.name

  allow {
    protocol = "tcp"
    ports    = ["443"]  # API de Kubernetes usa HTTPS (puerto 443)
  }

  source_ranges = ["0.0.0.0/0"]  # Puede limitarse a tu IP pública si lo prefieres
}

# Instancia de Cloud SQL
resource "google_sql_database_instance" "auth_db_instance" {
  name             = "auth-db-instance"
  database_version = "POSTGRES_14"
  region           = var.region

  settings {
    tier = "db-f1-micro"
    ip_configuration {
      ipv4_enabled = false
      private_network = google_compute_network.vpc_network.self_link
    }
  }
}

# Base de datos dentro de la instancia
resource "google_sql_database" "auth_db" {
  name     = "authdb"
  instance = google_sql_database_instance.auth_db_instance.name
}

# Usuario de la base de datos
resource "google_sql_user" "auth_user" {
  name     = "authuser"
  instance = google_sql_database_instance.auth_db_instance.name
  password = var.db_password
}

# Conector para GKE y Cloud SQL (opcional)
resource "google_service_networking_connection" "private_vpc_connection" {
  network                 = google_compute_network.vpc_network.id
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.private_ip_range.name]
}

resource "google_compute_global_address" "private_ip_range" {
  name          = "auth-service-private-ip-range"
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 16
  network       = google_compute_network.vpc_network.id
}