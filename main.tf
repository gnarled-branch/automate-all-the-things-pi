provider "aws" { 
  region= var.region
  access_key= var.deployment_username
  secret_key = var.deployment_password
 }
