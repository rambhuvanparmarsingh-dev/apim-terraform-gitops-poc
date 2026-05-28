module "api" {
  source             = "../../modules/apim-api"
  api_name           = "user-profile-service"
  display_name       = "User Profile Service"
  path               = "user-profile"
  protocols          = ["https"]
  swagger_file_path  = "swagger.json"
  policy_file_path   = "policy.xml"
  product_ids        = ["starter", "unlimited"]
}