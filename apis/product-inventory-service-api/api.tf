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

resource "azurerm_api_management_api_policy" "api_policy" {
  api_name            = azurerm_api_management_api.api.name
  api_management_name = var.apim_name
  resource_group_name = var.resource_group_name

  xml_content = file(var.policy_xml_path)
}

resource "azurerm_api_management_product" "product" {
  product_id            = "${var.api_name}-product"
  api_management_name   = var.apim_name
  resource_group_name   = var.resource_group_name
  display_name          = "Retail-Core-Product"
  published             = true
  subscription_required = true
  approval_required     = false
}

resource "azurerm_api_management_product_api" "product_api_link" {
  api_name            = azurerm_api_management_api.api.name
  product_id          = azurerm_api_management_product.product.product_id
  api_management_name = var.apim_name
  resource_group_name = var.resource_group_name
}

resource "azurerm_api_management_product_policy" "product_policy" {
  product_id          = azurerm_api_management_product.product.product_id
  api_management_name = var.apim_name
  resource_group_name = var.resource_group_name

  xml_content = <<XML
<policies>
    <inbound>
        <rate-limit calls="10" renewal-period="86400" />
    </inbound>
    <backend>
        <forward-request />
    </backend>
    <outbound>
        <base />
    </outbound>
</policies>
XML
}