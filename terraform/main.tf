resource "google_container_cluster" "primary" {
  name     = var.cluster_name
  location = "europe-west4"
  initial_node_count = 1

  remove_default_node_pool = true

  node_config {
    machine_type = var.machine_type
    disk_size_gb = 50
    disk_type    = "pd-standard"
    oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]
  }

  logging_service   = "logging.googleapis.com/kubernetes"
  monitoring_service = "monitoring.googleapis.com/kubernetes"
  
  private_cluster_config {
    enable_private_nodes = true
    master_ipv4_cidr_block = "10.0.0.0/28"
  }

  node_locations = ["europe-west4-a", "europe-west4-b", "europe-west4-c"]

  deletion_protection = false

}

resource "google_container_node_pool" "primary_nodes" {
  cluster    = google_container_cluster.primary.name
  location   = google_container_cluster.primary.location
  initial_node_count = 1  # Un solo nodo inicialmente en europe-west4-a

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
    min_node_count = 1
    max_node_count = 5
  }

  # Zona inicial del primer nodo
  node_locations = ["europe-west4-a", "europe-west4-b", "europe-west4-c"]  # Escalar en varias zonas
}
