# 1. OpenAPI Spec (JSON) के ज़रिए API क्रिएट करना
resource "azurerm_api_management_api" "api" {
  name                = var.api_name
  resource_group_name = var.resource_group_name
  api_management_name = var.apim_name
  revision            = "1"
  display_name        = var.api_display_name
  path                = var.api_path
  protocols           = ["https"]

  import {
    content_format = "openapi+json"
    content_value  = file(var.openapi_spec_path)
  }
}

# 2. उस API पर XML पॉलिसी अप्लाई करना
resource "azurerm_api_management_api_policy" "api_policy" {
  api_name            = azurerm_api_management_api.api.name
  api_management_name = var.apim_name
  resource_group_name = var.resource_group_name

  xml_content = file(var.policy_xml_path)
}

# 3. नया प्रोडक्ट (Product) क्रिएट करना
resource "azurerm_api_management_product" "product" {
  product_id            = "${var.api_name}-product"
  api_management_name   = var.apim_name
  resource_group_name   = var.resource_group_name
  display_name          = "${var.api_display_name} Product"
  subscription_required = true
  approval_required     = false
  published             = true
}

# 4. क्रिएट की गई API को इस प्रोडक्ट के साथ लिंक/जोड़ना
resource "azurerm_api_management_product_api" "product_api_link" {
  api_name            = azurerm_api_management_api.api.name
  product_id          = azurerm_api_management_product.product.product_id
  api_management_name = var.apim_name
  resource_group_name = var.resource_group_name
}

# 5. इस प्रोडक्ट के ऊपर प्रोडक्ट-लेवल XML पॉलिसी लगाना
resource "azurerm_api_management_product_policy" "product_policy" {
  product_id          = azurerm_api_management_product.product.product_id
  api_management_name = var.apim_name
  resource_group_name = var.resource_group_name

  # हम मानकर चल रहे हैं कि प्रोडक्ट पॉलिसी की फाइल का पाथ भी हम पास करेंगे
  xml_content = file(var.product_policy_xml_path)
}

# 6. 'PetStore-Premium' Product क्रिएट करना
resource "azurerm_api_management_product" "petstore_premium_product" {
  product_id            = "PetStore-Premium"
  api_management_name   = var.apim_name
  resource_group_name   = var.resource_group_name
  display_name          = "PetStore Premium"
  subscription_required = true
  approval_required     = false
  published             = true
}

# 7. 'PetStore-Premium' Product के लिए '/pets' Endpoint को लिंक करना
resource "azurerm_api_management_product_api" "petstore_premium_product_api_link" {
  api_name            = azurerm_api_management_api.api.name
  product_id          = azurerm_api_management_product.petstore_premium_product.product_id
  api_management_name = var.apim_name
  resource_group_name = var.resource_group_name
}

# 8. 'PetStore-Premium' Product के लिए XML पॉलिसी लगाना
resource "azurerm_api_management_product_policy" "petstore_premium_product_policy" {
  product_id          = azurerm_api_management_product.petstore_premium_product.product_id
  api_management_name = var.apim_name
  resource_group_name = var.resource_group_name

  xml_content = <<XML
<inbound>
    <rate-limit-by-key calls="100" renewal-period="60" counter-key="@(context.Subscription.Id)" />
    <quota-by-key calls="5000" renewal-period="86400" counter-key="@(context.Subscription.Id)" />
</inbound>
XML
}

# 9. 'PetStore-Premium' Product के लिए Subscription क्रिएट करना
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