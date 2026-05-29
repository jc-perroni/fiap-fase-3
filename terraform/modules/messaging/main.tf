# ─── Fila SQS — evaluation-service ───────────────────────────────────────────
resource "aws_sqs_queue" "evaluation" {
  name                       = "${var.project_name}-evaluation-sqs"
  delay_seconds              = 0
  max_message_size           = 262144  # 256 KB
  message_retention_seconds  = 86400   # 1 dia
  receive_wait_time_seconds  = 10      # Long polling
  visibility_timeout_seconds = 30

  tags = {
    Name        = "${var.project_name}-evaluation-sqs"
    Environment = var.environment
  }
}
