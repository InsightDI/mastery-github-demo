terraform {
  backend "azurerm" {
    resource_group_name  = "Terraform-state"
    storage_account_name = "grizzletffiles"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }
  required_version = ">= 0.12.29"
}

provider "azurerm" {
  version         = "2.14"
  subscription_id = var.subscription_id
  client_id       = var.client_id
  client_secret   = var.client_secret
  tenant_id       = var.tenant_id
  features {}
}

provider "random" {
  version = "2.3.0"
}