# 1. टेस्टिंग के लिए एक नया रिसोर्स ग्रुप बनाना
resource "azurerm_resource_group" "rg" {
  name     = "rg-apim-gitops-poc-dev"
  location = "East US" # आप अपनी पसंद का कोई भी रीजन चुन सकते हैं
}

# 2. Consumption Tier APIM (यह पर्सनल टेस्टिंग के लिए बेस्ट और किफायती है)
resource "azurerm_api_management" "apim" {
  name                = "apim-gitops-poc-service" # ध्यान रहे यह नाम पूरे Azure में यूनिक होना चाहिए
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  publisher_name      = "Rambhavan Parmar"
  publisher_email     = "rambhuvanparmarsingh@gmail.com" # यहाँ अपना ईमेल डाल सकते हैं

  sku_name = "Consumption_0"
}

# पेटस्टोर API को ऑनबोर्ड करने के लिए मॉड्यूल को कॉल करना
module "petstore_api_onboarding" {
  source = "./modules/apim-api-onboarding"

  resource_group_name = azurerm_resource_group.rg.name
  apim_name           = azurerm_api_management.apim.name

  api_name                = "petstore-api"
  api_display_name        = "Petstore Demo API"
  api_path                = "petstore"
  openapi_spec_path       = "./apis/petstore-api/openapi.json"
  policy_xml_path         = "./apis/petstore-api/policy.xml"
  product_policy_xml_path = "./apis/petstore-api/product-policy.xml" # <-- नया वेरिएबल यहाँ जोड़ा गया है

  # New variables for product/subscription management
  product_name            = "PetStore-Premium"
  product_display_name    = "PetStore Premium"
  product_description     = "Premium access to PetStore API"
  subscription_required   = true
  approval_required       = false
  subscriptions_limit     = 1
  product_policy_xml_path = "./apis/petstore-api/premium-product-policy.xml"
  endpoint_access_path    = "/pets"
  rate_limit              = 100
  quota_limit             = 5000
  quota_renewal_period    = 86400
}