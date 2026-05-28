resource "azurerm_api_management_product" "petstore_api_PetStore_Premium_product" {
  product_id            = "PetStore-Premium"
  api_management_name   = azurerm_api_management.apim.name
  resource_group_name   = azurerm_resource_group.rg.name
  display_name          = "PetStore Premium"
  subscription_required = true
  approval_required     = false
  published             = true
}

resource "azurerm_api_management_product_api" "petstore_api_PetStore_Premium_product_api" {
  api_name            = module.petstore_api_onboarding.api_name
  product_id          = azurerm_api_management_product.petstore_api_PetStore_Premium_product.product_id
  api_management_name = azurerm_api_management.apim.name
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_api_management_subscription" "petstore_api_PetStore_Premium_subscription" {
  name                = "PetStore-Premium-Subscription"
  api_management_name = azurerm_api_management.apim.name
  resource_group_name = azurerm_resource_group.rg.name
  product_id          = azurerm_api_management_product.petstore_api_PetStore_Premium_product.product_id
  display_name        = "PetStore Premium Subscription"
  primary_key         = "primary-key-value" # Replace with actual key generation logic
  secondary_key       = "secondary-key-value" # Replace with actual key generation logic
}

resource "azurerm_api_management_product_policy" "petstore_api_PetStore_Premium_product_policy" {
  product_id          = azurerm_api_management_product.petstore_api_PetStore_Premium_product.product_id
  api_management_name = azurerm_api_management.apim.name
  resource_group_name = azurerm_resource_group.rg.name

  xml_content = file("apis/petstore-api/product-PetStore-Premium-policy.xml")
}