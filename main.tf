terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "4.16.0"
    }
  }
}

provider "azurerm" {
    features {}
    subscription_id = var.subscription_id
}

variable "subscription_id" {
    type = string
    description = "The Azure subscription ID"
}
variable "acr_username" {}
variable "acr_password" {}


# create rg
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
    image  = "dinethsiriwardana.azurecr.io/dinethsiriwardana.azurecr.io:latest" # Replace with your image
    cpu    = "0.5"
    memory = "1.5"
    ports {
      port     = 80
      protocol = "TCP"
    }
  }
image_registry_credential {
    server   = "dinethsiriwardana.azurecr.io"
    username = var.acr_username
    password = var.acr_password
  }

  tags = {
    environment = "dev"
  }
}




# output
# Container ip address
output "container_ip_address" {
  value = azurerm_container_group.container-az-tf-mschamps.ip_address
}