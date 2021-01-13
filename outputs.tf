output "cluster_id" {
  description = "EKS cluster ID."
  value       = ""
}

output "cluster_endpoint" {
  description = "Endpoint for EKS control plane."
  value       = ""
}

output "cluster_security_group_id" {
  description = "Security group ids attached to the cluster control plane."
  value       = ""
}

output "kubectl_config" {
  description = "kubectl config as generated by the module."
  value       = ""
}

output "config_map_aws_auth" {
  description = "A kubernetes configuration to authenticate to this EKS cluster."
  value       = ""
}

output "region" {
  description = "AWS region"
  value       = var.region
}

output "cluster_name" {
  description = "Kubernetes Cluster Name"
  value       = ""
}

output "app_url" {
  value = format("%s%s/%s","http://", kubernetes_service.app.load_balancer_ingress[0].ip,"url")
  #value = kubernetes_service.app.spec
}
