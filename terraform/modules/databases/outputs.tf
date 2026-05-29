output "rds_auth_endpoint" {
  description = "Endpoint (host:porta) do RDS auth-service"
  value       = aws_db_instance.auth.endpoint
}

output "rds_flag_endpoint" {
  description = "Endpoint (host:porta) do RDS flag-service"
  value       = aws_db_instance.flag.endpoint
}

output "rds_targeting_endpoint" {
  description = "Endpoint (host:porta) do RDS targeting-service"
  value       = aws_db_instance.targeting.endpoint
}

output "rds_auth_address" {
  description = "Hostname do RDS auth-service (sem porta)"
  value       = aws_db_instance.auth.address
}

output "rds_flag_address" {
  description = "Hostname do RDS flag-service (sem porta)"
  value       = aws_db_instance.flag.address
}

output "rds_targeting_address" {
  description = "Hostname do RDS targeting-service (sem porta)"
  value       = aws_db_instance.targeting.address
}

output "elasticache_endpoint" {
  description = "Hostname do ElastiCache Redis"
  value       = aws_elasticache_cluster.redis.cache_nodes[0].address
}

output "elasticache_port" {
  description = "Porta do ElastiCache Redis"
  value       = aws_elasticache_cluster.redis.cache_nodes[0].port
}

output "dynamodb_table_name" {
  description = "Nome da tabela DynamoDB"
  value       = aws_dynamodb_table.analytics.name
}

output "dynamodb_table_arn" {
  description = "ARN da tabela DynamoDB"
  value       = aws_dynamodb_table.analytics.arn
}
