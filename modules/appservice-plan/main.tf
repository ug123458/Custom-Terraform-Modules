resource "azurerm_service_plan" "app_service_plan" {
  name = var.name
  resource_group_name = var.resource_group_name
  location=var.location
  sku_name = "Y1"
  os_type = "Linux"
}