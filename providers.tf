terraform {
  required_version = ">= 1.0.0"

  # यह ब्लॉक आपके लोकल टेराफॉर्म को आपके बनाए गए टेराफॉर्म क्लाउड वर्कस्पेस से लिंक करेगा
  cloud {
    organization = "Ramparorg" # आपकी ऑर्गेनाइजेशन का नाम

    workspaces {
      name = "apim-terraform-gitops-poc" # आपके वर्कस्पेस का नाम
    }
  }

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

provider "azurerm" {
  features {}
}