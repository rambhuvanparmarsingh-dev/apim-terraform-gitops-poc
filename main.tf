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

  sku_name = "Consumption-1"
}