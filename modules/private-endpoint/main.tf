resource "azurerm_private_endpoint" "private_endpoint" {
  name                = var.private_endpoint_name
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.subnet_id
  private_service_connection {
    name                           = "psc-${var.sql_server_name}"
    is_manual_connection           = false
    private_connection_resource_id = var.sql_server_id
    subresource_names              = ["sqlServer"]
  }
}
