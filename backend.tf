terraform {
  required_version = "1.15.6"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.77.0"
    }

    random = {
      source  = "hashicorp/random"
      version = "3.9.0"
    }

    local = {
      source  = "hashicorp/local"
      version = "2.9.0"
    }
  }
}