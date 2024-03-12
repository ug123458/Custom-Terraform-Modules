

# Create a virtual network
resource "azurerm_virtual_network" "vnet" {
  resource_group_name = var.resource_group_name
  location            = var.resource_group_location
  name                = var.name
  address_space       = var.address_space
}