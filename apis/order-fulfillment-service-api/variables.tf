variable "api_name" {
  type        = string
  description = "The APIM API resource name"
}

variable "api_display_name" {
  type        = string
  description = "Human-readable display name for the API"
}

variable "api_path" {
  type        = string
  description = "The API URL path suffix"
}

variable "apim_name" {
  type        = string
  description = "The APIM instance name"
}

variable "resource_group_name" {
  type        = string
  description = "The Azure resource group name"
}

variable "openapi_spec_path" {
  type        = string
  description = "Path to the OpenAPI spec JSON file"
}

variable "policy_xml_path" {
  type        = string
  description = "Path to the boilerplate policy.xml file"
}