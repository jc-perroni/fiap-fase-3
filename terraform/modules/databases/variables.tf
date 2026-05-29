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

variable "vpc_cidr" {
  description = "CIDR block da VPC (usado nos Security Groups)"
  type        = string
}

variable "private_subnet_ids" {
  description = "IDs das subnets privadas"
  type        = list(string)
}

variable "db_password" {
  description = "Senha dos bancos RDS"
  type        = string
  sensitive   = true
}

variable "db_instance_class" {
  description = "Classe de instância RDS"
  type        = string
  default     = "db.t3.micro"
}

variable "cache_node_type" {
  description = "Tipo de nó ElastiCache"
  type        = string
  default     = "cache.t3.micro"
}

variable "dynamodb_table_name" {
  description = "Nome da tabela DynamoDB"
  type        = string
  default     = "ToggleMasterAnalytics"
}
