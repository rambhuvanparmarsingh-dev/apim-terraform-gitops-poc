module "product-inventory-service-api" {
  source             = "../../modules/apim-api"
  api_name           = var.api_name
  display_name       = var.api_display_name
  path               = var.api_path
  protocols          = ["https"]
  swagger_file_path  = "inventory-swagger.json"
  policy_file_path   = "policy.xml"
}