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
# पेटस्टोर API को ऑनबोर्ड करने के लिए मॉड्यूल को कॉल करना
module "petstore_api_onboarding" {
  source = "./modules/apim-api-onboarding"

  resource_group_name = azurerm_resource_group.rg.name
  apim_name           = azurerm_api_management.apim.name

  api_name          = "petstore-api"
  api_display_name  = "Petstore Demo API"
  api_path          = "petstore"
  openapi_spec_path = "./apis/petstore-api/openapi.json"
  policy_xml_path   = "./apis/petstore-api/policy.xml"
}