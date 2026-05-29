output "sqs_queue_url" {
  description = "URL da fila SQS"
  value       = aws_sqs_queue.evaluation.url
}

output "sqs_queue_arn" {
  description = "ARN da fila SQS"
  value       = aws_sqs_queue.evaluation.arn
}

output "sqs_queue_name" {
  description = "Nome da fila SQS"
  value       = aws_sqs_queue.evaluation.name
}
