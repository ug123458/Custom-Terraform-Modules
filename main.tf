# Create a resource group
module "rg" {
  source = "./modules/resource-group"
  prefix = var.resource_group_name
  location = var.location
}

# Create a vnet 
module "vnet" {
  source = "./modules/vnet"
  name = var.vnet_name
  resource_group_name = module.rg.resource_group_name
  resource_group_location = module.rg.resource_group_location
  address_space = var.address_space
}

# Create a subnet
module "subnet" {
  source = "./modules/subnet"
  name = var.subnet_name
  resource_group_name = module.rg.resource_group_name
  virtual_network_name = module.vnet.virtual_network_name
  address_prefixes = var.address_prefixes
}

module "storage_acc" {
  source = "./modules/storage-account"
  name = var.storage_account_name
  resource_group_name = module.rg.resource_group_name
  location = module.rg.resource_group_location
  account_tier = "Standard"
  account_replication_type = "LRS"
}


module "appservice_plan" {
  source = "./modules/appservice-plan"
  name = var.app_service_plan_name
  location = module.rg.resource_group_location
  resource_group_name = module.rg.resource_group_name
  sku_tier = "Standard"
  sku_size = "S1"
}


# Create a function app
resource "azurerm_function_app" "example" {
  name                       = var.function_app_name
  location                   = module.rg.resource_group_location
  resource_group_name        = module.rg.resource_group_name
  app_service_plan_id        = module.appservice_plan.id
  storage_account_name       = module.storage_acc.name
  storage_account_access_key = module.storage_acc.access_key
  os_type                    = "linux"
  https_only                 = true

  app_settings = {
    FUNCTIONS_WORKER_RUNTIME = "node"
    WEBSITE_RUN_FROM_PACKAGE = "1"
  }

  site_config {
    always_on        = true
    ftps_state       = "Disabled"
    http2_enabled    = true
    use_32_bit_worker_process = false
  }
}

# Create a SQL Server
resource "azurerm_sql_server" "example" {
  name                         = var.sql_server_name
  resource_group_name          = module.rg.resource_group_name
  location                     = module.rg.resource_group_location
  version                      = "12.0"
  administrator_login          = "adminuser"
  administrator_login_password = "AdminPassword123!"

  tags = {
    environment = "production"
  }
}

# Create a SQL Database
resource "azurerm_sql_database" "example" {
  name                = var.sql_database_name
  resource_group_name = module.rg.resource_group_name
  server_name         = azurerm_sql_server.example.name
  location            = module.rg.resource_group_location
  edition             = "Standard"
  collation           = "SQL_Latin1_General_CP1_CI_AS"
  max_size_bytes      = "1073741824"
  create_mode         = "Default"
}


module "private_endpoint" {
  source = "./modules/private-endpoint"
  private_endpoint_name = var.private_endpoint_name
  location = module.rg.resource_group_location
  resource_group_name = module.rg.resource_group_name
  subnet_id = module.subnet.subnet_id
  sql_server_id = azurerm_sql_server.example.id
  sql_server_name = var.sql_server_name

}