output "cluster_name" {
  description = "Nome do cluster EKS"
  value       = aws_eks_cluster.main.name
}

output "cluster_endpoint" {
  description = "Endpoint da API Kubernetes"
  value       = aws_eks_cluster.main.endpoint
}

output "cluster_certificate_authority" {
  description = "Certificate Authority do cluster (base64)"
  value       = aws_eks_cluster.main.certificate_authority[0].data
}

output "cluster_oidc_issuer" {
  description = "OIDC issuer URL do cluster (útil para IRSA)"
  value       = aws_eks_cluster.main.identity[0].oidc[0].issuer
}

output "node_group_arn" {
  description = "ARN do Node Group"
  value       = aws_eks_node_group.main.arn
}

output "kubeconfig_command" {
  description = "Comando para configurar o kubeconfig localmente"
  value       = "aws eks update-kubeconfig --region us-east-1 --name ${aws_eks_cluster.main.name}"
}
