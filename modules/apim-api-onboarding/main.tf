variable "product_PetStore_Premium_policy_xml_path" {
  description = "Path to the XML policy file for the PetStore-Premium product."
}

resource "azurerm_api_management_product" "petstore_premium_product" {
  product_id            = "PetStore-Premium"
  api_management_name   = var.apim_name
  resource_group_name   = var.resource_group_name
  display_name          = "PetStore Premium Product"
  subscription_required = true
  approval_required     = false
  published             = true
}

resource "azurerm_api_management_product_api" "petstore_premium_product_api_link" {
  api_name            = azurerm_api_management_api.api.name
  product_id          = azurerm_api_management_product.petstore_premium_product.product_id
  api_management_name = var.apim_name
  resource_group_name = var.resource_group_name
}

resource "azurerm_api_management_subscription" "petstore_premium_subscription" {
  name                = "PetStore-Premium-Subscription"
  api_management_name = var.apim_name
  resource_group_name = var.resource_group_name
  product_id          = azurerm_api_management_product.petstore_premium_product.product_id
  display_name        = "PetStore Premium Subscription"
  primary_key         = null
  secondary_key       = null
  state               = "active"
}

resource "azurerm_api_management_product_policy" "petstore_premium_product_policy" {
  product_id          = azurerm_api_management_product.petstore_premium_product.product_id
  api_management_name = var.apim_name
  resource_group_name = var.resource_group_name

  xml_content = file(var.product_PetStore_Premium_policy_xml_path)
}