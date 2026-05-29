output "vpc_id" {
  description = "ID da VPC"
  value       = module.networking.vpc_id
}

output "public_subnet_ids" {
  description = "IDs das subnets públicas"
  value       = module.networking.public_subnet_ids
}

output "private_subnet_ids" {
  description = "IDs das subnets privadas"
  value       = module.networking.private_subnet_ids
}

output "eks_cluster_name" {
  description = "Nome do cluster EKS"
  value       = module.eks.cluster_name
}

output "eks_cluster_endpoint" {
  description = "Endpoint da API do cluster EKS"
  value       = module.eks.cluster_endpoint
}

output "eks_cluster_certificate_authority" {
  description = "Certificate Authority do cluster EKS (base64)"
  value       = module.eks.cluster_certificate_authority
  sensitive   = true
}

output "rds_auth_endpoint" {
  description = "Endpoint RDS do auth-service"
  value       = module.databases.rds_auth_endpoint
}

output "rds_flag_endpoint" {
  description = "Endpoint RDS do flag-service"
  value       = module.databases.rds_flag_endpoint
}

output "rds_targeting_endpoint" {
  description = "Endpoint RDS do targeting-service"
  value       = module.databases.rds_targeting_endpoint
}

output "elasticache_endpoint" {
  description = "Endpoint do ElastiCache Redis"
  value       = module.databases.elasticache_endpoint
}

output "elasticache_port" {
  description = "Porta do ElastiCache Redis"
  value       = module.databases.elasticache_port
}

output "dynamodb_table_name" {
  description = "Nome da tabela DynamoDB"
  value       = module.databases.dynamodb_table_name
}

# ─── GitOps / ArgoCD ──────────────────────────────────────────────────────────
output "argocd_helm_status" {
  description = "Status do Helm release do ArgoCD"
  value       = module.argocd.helm_release_status
}

output "argocd_namespace" {
  description = "Namespace onde o ArgoCD foi instalado"
  value       = module.argocd.argocd_namespace
}

output "argocd_get_password_command" {
  description = "Comando para obter a senha inicial do ArgoCD"
  value       = "kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath='{.data.password}' | base64 -d"
}

output "argocd_get_lb_url_command" {
  description = "Comando para obter a URL do LoadBalancer do ArgoCD"
  value       = "kubectl -n argocd get svc argocd-server -o jsonpath='{.status.loadBalancer.ingress[0].hostname}'"
}


output "sqs_queue_url" {
  description = "URL da fila SQS"
  value       = module.messaging.sqs_queue_url
}

output "sqs_queue_arn" {
  description = "ARN da fila SQS"
  value       = module.messaging.sqs_queue_arn
}

output "ecr_repository_urls" {
  description = "URLs dos repositórios ECR"
  value       = module.ecr.repository_urls
}
