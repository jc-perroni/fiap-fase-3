# ─── Geral ───────────────────────────────────────────────────────────────────
variable "aws_region" {
  description = "Região AWS onde os recursos serão provisionados"
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "Prefixo usado no nome de todos os recursos"
  type        = string
  default     = "feature-flags"
}

variable "environment" {
  description = "Ambiente (ex: production, staging)"
  type        = string
  default     = "production"
}

# ─── Networking ──────────────────────────────────────────────────────────────
variable "vpc_cidr" {
  description = "CIDR block da VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "availability_zones" {
  description = "Zonas de disponibilidade a serem usadas"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
}

variable "public_subnet_cidrs" {
  description = "CIDRs das subnets públicas (uma por AZ)"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnet_cidrs" {
  description = "CIDRs das subnets privadas (uma por AZ)"
  type        = list(string)
  default     = ["10.0.10.0/24", "10.0.20.0/24"]
}

# ─── Databases ───────────────────────────────────────────────────────────────
variable "db_password" {
  description = "Senha dos bancos RDS PostgreSQL. Use TF_VAR_db_password ou um tfvars não-commitado."
  type        = string
  sensitive   = true
}

variable "db_instance_class" {
  description = "Classe de instância RDS"
  type        = string
  default     = "db.t3.micro"
}

variable "cache_node_type" {
  description = "Tipo de nó ElastiCache Redis"
  type        = string
  default     = "cache.t3.micro"
}

variable "dynamodb_table_name" {
  description = "Nome da tabela DynamoDB"
  type        = string
  default     = "ToggleMasterAnalytics"
}

# ─── Mensageria ───────────────────────────────────────────────────────────────
# (Sem variáveis adicionais além de project_name/environment)

# ─── ECR ─────────────────────────────────────────────────────────────────────
variable "ecr_repository_names" {
  description = "Nomes dos repositórios ECR a serem criados"
  type        = list(string)
  default = [
    "pos2/auth-service",
    "pos2/flag-service",
    "pos2/targeting-service",
    "pos2/evaluation-service",
    "pos2/analytics-service",
  ]
}

# ─── EKS ─────────────────────────────────────────────────────────────────────
variable "node_instance_type" {
  description = "Tipo de instância EC2 dos nodes EKS"
  type        = string
  default     = "t3.medium"
}

variable "node_desired_size" {
  description = "Quantidade desejada de nodes EKS"
  type        = number
  default     = 2
}

variable "node_min_size" {
  description = "Quantidade mínima de nodes EKS"
  type        = number
  default     = 1
}

variable "node_max_size" {
  description = "Quantidade máxima de nodes EKS"
  type        = number
  default     = 4
}

# ─── GitOps / ArgoCD ──────────────────────────────────────────────────────────
variable "gitops_repo_url" {
  description = "URL HTTPS do repositório GitHub contendo os manifestos GitOps (ex: https://github.com/OWNER/REPO.git)"
  type        = string
}

variable "gitops_target_revision" {
  description = "Branch que o ArgoCD monitora no repositório GitOps"
  type        = string
  default     = "main"
}
