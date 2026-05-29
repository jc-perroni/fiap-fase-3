output "repository_urls" {
  description = "Mapa de nome → URL do repositório ECR"
  value       = { for name, repo in aws_ecr_repository.repos : name => repo.repository_url }
}

output "repository_arns" {
  description = "Mapa de nome → ARN do repositório ECR"
  value       = { for name, repo in aws_ecr_repository.repos : name => repo.arn }
}

output "registry_id" {
  description = "ID do registry ECR (account ID)"
  value       = values(aws_ecr_repository.repos)[0].registry_id
}
