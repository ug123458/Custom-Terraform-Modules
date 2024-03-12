resource "azurerm_network_interface" "network_interface" {

  name                = "${var.prefix}-nic"
  location            = var.location
  resource_group_name = var.resource_group_name
  ip_configuration {
    name                          = "${var.prefix}-nic-ip"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = try(var.public_ip_address_id, null)
  }
}