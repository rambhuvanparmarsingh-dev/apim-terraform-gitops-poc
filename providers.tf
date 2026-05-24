terraform {
  # आपके सिस्टम में मौजूद v1.14.9 या उससे ऊपर के वर्जन को अनुमति देने के लिए
  required_version = ">= 1.14.9"

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