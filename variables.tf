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
  default     = "utkfunctionapp"
}

variable "storage_account_name" {
  description = "Name of the storage account"
  type        = string
  default     = "utkarshstorageacc"
}

variable "sql_server_name" {
  description = "Name of the SQL Server"
  type        = string
  default     = "utksqlserver"
}

variable "sql_database_name" {
  description = "Name of the SQL Database"
  type        = string
  default     = "sql_database"
}

variable "vnet_name" {
  description = "Name of the Virtual Network"
  type        = string
  default     = "defaultvnet"
}

variable "subnet_name" {
  description = "Name of the Subnet"
  type        = string
  default     = "defaultsubnet"
}

variable "app_service_plan_name" {
  description = "Name of the App Service Plan"
  type        = string
  default     = "defaultappserviceplan"
}

variable "private_endpoint_name" {
  description = "Name of the private endpoint"
  type        = string
  default     = "defaultprivateendpoint"
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
