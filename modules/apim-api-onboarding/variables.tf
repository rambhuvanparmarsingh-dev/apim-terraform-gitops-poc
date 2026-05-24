variable "resource_group_name" {
  type        = string
  description = "Name of the Azure Resource Group"
}

variable "apim_name" {
  type        = string
  description = "Name of the Azure API Management service"
}

variable "api_name" {
  type        = string
  description = "Unique technical name for the API"
}

variable "api_display_name" {
  type        = string
  description = "Display name shown in Developer Portal"
}

variable "api_path" {
  type        = string
  description = "The URL prefix/context path for this API"
}

variable "openapi_spec_path" {
  type        = string
  description = "Local path to the OpenAPI specification JSON file"
}

variable "policy_xml_path" {
  type        = string
  description = "Local path to the API policy XML file"
}