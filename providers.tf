terraform {
  # टेराफॉर्म का बिल्कुल लेटेस्ट वर्जन लॉक करना
  required_version = ">= 1.15.0"

  cloud {
    organization = "Ramparorg"

    workspaces {
      name = "apim-terraform-gitops-poc"
    }
  }

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      # Azure प्रोवाइडर का सबसे लेटेस्ट v3/v4 स्टेबल सीरीज लॉक करना
      version = "~> 3.116.0" 
    }
  }
}

provider "azurerm" {
  features {}
}