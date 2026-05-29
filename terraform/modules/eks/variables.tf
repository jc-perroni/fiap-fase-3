variable "project_name" {
  description = "Prefixo dos recursos"
  type        = string
}

variable "environment" {
  description = "Ambiente"
  type        = string
}

variable "vpc_id" {
  description = "ID da VPC"
  type        = string
}

variable "private_subnet_ids" {
  description = "IDs das subnets privadas (onde ficam os nodes)"
  type        = list(string)
}

variable "public_subnet_ids" {
  description = "IDs das subnets publicas (Load Balancers)"
  type        = list(string)
}

variable "kubernetes_version" {
  description = "Versão do Kubernetes"
  type        = string
  default     = "1.31"
}

variable "node_instance_type" {
  description = "Tipo de instância EC2 dos worker nodes"
  type        = string
  default     = "t3.medium"
}

variable "node_desired_size" {
  description = "Número desejado de nodes"
  type        = number
  default     = 2
}

variable "node_min_size" {
  description = "Número mínimo de nodes"
  type        = number
  default     = 1
}

variable "node_max_size" {
  description = "Número máximo de nodes"
  type        = number
  default     = 4
}
