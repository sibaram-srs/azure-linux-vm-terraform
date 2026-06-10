terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.76.0"
    }
  }
}

provider "azurerm" {
  features {
  }
  subscription_id = "5377d8e3-d591-444c-8728-5bbf7bc30659"
}