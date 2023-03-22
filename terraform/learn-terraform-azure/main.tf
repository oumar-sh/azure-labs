# Configure the Azure provider
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0.2"
    }
  }

  required_version = ">= 1.1.0"
}

provider "azurerm" {
  features {}
}

# Create a resource group
resource "azurerm_resource_group" "rg" {
  name     = "terraform-lab-rg"
  location = "francecentral"
  tags = {
    Environment = "DEV",
    Team = "DEVOPS"
  }
}

# Create a virtual network
resource "azurerm_virtual_network" "vnet" {
  name                = "vnet-lab-terraform"
  address_space       = ["10.0.0.0/16"]
  location            = "francecentral"
  resource_group_name = azurerm_resource_group.rg.name
}
