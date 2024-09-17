output "cluster_endpoint" {
  description = "La IP pública del clúster de GKE"
  value       = google_container_cluster.primary.endpoint
}

output "cluster_name" {
  description = "El nombre del clúster de GKE"
  value       = google_container_cluster.primary.name
}

output "node_pool_zones" {
  description = "Las zonas donde se encuentran los nodos"
  value       = google_container_cluster.primary.node_locations
}

output "node_pool_size" {
  description = "El número de nodos en el pool de nodos"
  value       = google_container_node_pool.primary_nodes.node_count
}
