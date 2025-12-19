terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.54.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "rg-mano-stg" 
    storage_account_name = "stgtodomano"                   
    container_name       = "tfstate"                    
    key                  = "prod.terraform.tfstate"     
  }
}

provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
  subscription_id = "30795018-f759-40ff-9c87-7d73f6cc4d87"
}
