resource "azurerm_public_ip" "public_ip" {
  name                    = "${var.prefix}-public-ip"
  location                = var.location
  resource_group_name     = var.resource_group_name
  allocation_method       = var.allocation_method
  idle_timeout_in_minutes = 30
  domain_name_label       = "${var.prefix}-public-ip"
  sku                     = "Standard"

}