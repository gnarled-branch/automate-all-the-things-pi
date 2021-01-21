terraform {
	backend "remote" {
		organization = "KATA-FRIDAYS"
		workspaces {
			name = "automate-all-the-things-pi"
		}
	}
}

provider "azurerm" {
   client_id = var.deployment_client_id
   client_secret = var.deployment_client_secret
   subscription_id= var.deployment_subscription_id
   tenant_id= var.deployment_tenant_id
   skip_provider_registration = "true"
   features {}
}

