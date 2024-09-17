variable "project_id" {
  description = "El ID del proyecto en Google Cloud"
  type        = string
}

variable "region" {
  description = "Región para desplegar el clúster"
  type        = string
  default     = "europe-west4"
}

variable "credentials_file" {
  description = "Ruta al archivo de credenciales de la cuenta de servicio"
  type        = string
}

variable "cluster_name" {
  description = "Nombre del clúster de GKE"
  type        = string
  default     = "my-gke-cluster"
}

variable "machine_type" {
  description = "Tipo de máquina para los nodos del clúster"
  type        = string
  default     = "e2-medium"
}

variable "min_node_count" {
  description = "Número mínimo de nodos en el clúster"
  type        = number
  default     = 1
}

variable "max_node_count" {
  description = "Número máximo de nodos en el clúster"
  type        = number
  default     = 5
}
