output "argocd_server_url" {
  description = "URL do servidor ArgoCD (LoadBalancer — disponível após provisionamento do LB pela AWS)"
  value       = "http://${helm_release.argocd.name}.${helm_release.argocd.namespace}.svc.cluster.local"
}

output "helm_release_status" {
  description = "Status do Helm release do ArgoCD"
  value       = helm_release.argocd.status
}

output "argocd_namespace" {
  description = "Namespace onde o ArgoCD foi instalado"
  value       = kubernetes_namespace.argocd.metadata[0].name
}
