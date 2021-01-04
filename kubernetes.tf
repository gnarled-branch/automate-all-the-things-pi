# # Kubernetes provider
# # https://learn.hashicorp.com/terraform/kubernetes/provision-eks-cluster#optional-configure-terraform-kubernetes-provider
# # To learn how to schedule deployments and services using the provider, go here: https://learn.hashicorp.com/terraform/kubernetes/deploy-nginx-kubernetes

provider "kubernetes" {
  
load_config_file = false

host = var.host

client_certificate     = var.client_certificate
client_key             = var.client_key
cluster_ca_certificate = var.cluster_ca_certificate  
  
  
}
