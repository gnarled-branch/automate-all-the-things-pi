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

resource "azurerm_resource_group" "example" {
  name     = "${var.prefix}-resources"
  location = "${var.location}"
}

resource "azurerm_app_service_plan" "example" {
  name                = "${var.prefix}-asp"
  location            = "${azurerm_resource_group.example.location}"
  resource_group_name = "${azurerm_resource_group.example.name}"
  kind                = "xenon"
  is_xenon            = true

  sku {
    tier = "Standard"
    size = "S1"
  }
}

resource "azurerm_app_service" "example" {
  name                = "${var.prefix}-appservice"
  location            = "${azurerm_resource_group.example.location}"
  resource_group_name = "${azurerm_resource_group.example.name}"
  app_service_plan_id = "${azurerm_app_service_plan.example.id}"

  site_config {
    windows_fx_version = "DOCKER|index.docker.io/chrisgallivan/automate-all-the-things-pi3:latest"
  }

  app_settings = {
    "DOCKER_REGISTRY_SERVER_URL" = "https://index.docker.io",
    "DOCKER_REGISTRY_SERVER_USERNAME" = "",
    "DOCKER_REGISTRY_SERVER_PASSWORD" = "",
  }
}
