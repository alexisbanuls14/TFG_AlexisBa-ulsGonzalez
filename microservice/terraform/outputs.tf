output "cluster_endpoint" {
  description = "La IP pública del clúster de GKE"
  value       = google_container_cluster.primary.endpoint
}

output "cluster_name" {
  description = "El nombre del clúster de GKE"
  value       = google_container_cluster.primary.name
}

output "node_pool_size" {
  description = "Número de nodos en el pool de nodos"
  value       = google_container_node_pool.primary_nodes.node_count
}
