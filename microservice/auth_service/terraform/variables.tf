variable "project_id" {
  description = "El ID del proyecto en Google Cloud"
  type        = string
}

variable "credentials_file" {
  description = "Ruta al archivo de credenciales de la cuenta de servicio"
  type        = string
}

variable "region" {
  description = "Región para desplegar el clúster"
  type        = string
  default     = "europe-west4"
}

variable "vpc_name" {
  description = "Nombre la VPC de GKE"
  type        = string
  default     = "vpc-JWT-authentication"
}

variable "subnet_name" {
  description = "Nombre de la subred de GKE"
  type        = string
  default     = "JWT-authentication-subnet"
}

variable "cluster_name" {
  description = "Nombre del clúster de GKE"
  type        = string
  default     = "JWT-authentication-gke"
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

variable "nat_router" {
  description = "Nombre del router NAT"
  type        = string
  default     = "nat-router-JWT-authentication"
}

variable "nat_config" {
  description = "Nombre de la configuracion del NAT"
  type        = string
  default     = "nat-config-JWT-authentication"
}

variable "db_password" {
  description = "Password for the database user"
  sensitive   = true
}