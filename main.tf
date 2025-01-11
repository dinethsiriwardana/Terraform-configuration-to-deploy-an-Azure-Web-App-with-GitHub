terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "4.15.0"
    }
  }
}

provider "azurerm" {
    features {}
    subscription_id = var.subscription_id
}

variable "subscription_id" {
  description = "Azure subscription ID"
  type        = string
}
resource "azurerm_resource_group" "rg-az-tf-mschamps" {
  name     = "docker-container-rg"
  location = "East US"
}

resource "azurerm_container_group" "container-az-tf-mschamps" {
  name                = "docker-container-group"
  location            = azurerm_resource_group.rg-az-tf-mschamps.location
  resource_group_name = azurerm_resource_group.rg-az-tf-mschamps.name
  ip_address_type    = "Public"
  os_type            = "Linux"
  dns_name_label     = "myapp-container-az-tf-mschamps"

  container {
    name   = "my-docker-container"
    image  = "dinethsiriwardana/slcitiesfront:latest" # Replace with your image
    cpu    = "0.5"
    memory = "1.5"

    ports {
      port     = 80
      protocol = "TCP"
    }

  }
  tags = {
    environment = "dev"
  }
}

output "container_ip_address" {
  value = azurerm_container_group.container-az-tf-mschamps.ip_address
}

# Output the FQDN
output "container_fqdn" {
  value = azurerm_container_group.container-az-tf-mschamps.fqdn
}