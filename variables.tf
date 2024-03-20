variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
  default     = "default_resource_group"
}

variable "location" {
  description = "Azure region where the resources will be deployed"
  type        = string
  default     = "westus"
}

variable "function_app_name" {
  description = "Name of the function app"
  type        = string
  default     = "default_function_app"
}

variable "storage_account_name" {
  description = "Name of the storage account"
  type        = string
  default     = "default_storage_account"
}

variable "sql_server_name" {
  description = "Name of the SQL Server"
  type        = string
  default     = "default_sql_server"
}

variable "sql_database_name" {
  description = "Name of the SQL Database"
  type        = string
  default     = "default_sql_database"
}

variable "vnet_name" {
  description = "Name of the Virtual Network"
  type        = string
  default     = "default_vnet"
}

variable "subnet_name" {
  description = "Name of the Subnet"
  type        = string
  default     = "default_subnet"
}

variable "app_service_plan_name" {
  description = "Name of the App Service Plan"
  type        = string
  default     = "default_app_service_plan"
}

variable "private_endpoint_name" {
  description = "Name of the private endpoint"
  type        = string
  default     = "default_private_endpoint"
}

variable "address_prefixes" {
  description = "Address prefixes for the subnet"
  type        = list(string)
  default     = ["10.0.0.0/16"]
}

variable "address_space" {
  description = "Address space for the virtual network"
  type        = list(string)
  default     = ["10.0.0.0/16"]
}