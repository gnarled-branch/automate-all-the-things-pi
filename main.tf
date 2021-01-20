terraform {
	backend "remote" {
		organization = "KATA-FRIDAYS"
		workspaces {
			name = "automate-all-the-things-pi"
		}
	}
}


provider "aws" { 
  region= var.region
  access_key= var.deployment_username
  secret_key = var.deployment_password
 }
