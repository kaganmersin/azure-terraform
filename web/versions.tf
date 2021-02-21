terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "2.23.0"
    }
    random = {
      source = "hashicorp/random"
      version = "2.2"
    }
  }
  required_version = ">= 0.13"
}
