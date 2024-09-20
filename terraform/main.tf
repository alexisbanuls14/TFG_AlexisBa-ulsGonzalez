resource "google_container_cluster" "primary" {
  name     = var.cluster_name
  location = var.region
  initial_node_count = 1  # Solo 1 nodo al inicio en la zona por defecto (europe-west4-a)

  remove_default_node_pool = true  # No crear el node pool por defecto

  logging_service   = "logging.googleapis.com/kubernetes"
  monitoring_service = "monitoring.googleapis.com/kubernetes"
  
  private_cluster_config {
    enable_private_nodes = true
    master_ipv4_cidr_block = "10.0.0.0/28"
  }

  deletion_protection = false
}

resource "google_container_node_pool" "primary_nodes" {
  cluster    = google_container_cluster.primary.name
  location   = google_container_cluster.primary.location

  # Crear un solo nodo inicial
  initial_node_count = 1  # Un solo nodo inicialmente en la zona europe-west4-a

  # Configuración del nodo
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
    min_node_count = 1  # Mínimo 1 nodo
    max_node_count = 5  # Máximo 5 nodos
  }

  # No especificamos zonas aquí para asegurar que solo se cree un nodo en la zona predeterminada
  # Zonas adicionales se agregarán cuando GKE escale según la demanda
}
