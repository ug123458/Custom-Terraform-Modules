module "resource_group" {
  source   = "./modules/resource-group"
  prefix   = var.prefix
  location = "centralindia"
}

# Create a virtual network

module "vnet" {
  source                  = "./modules/vnet"
  resource_group_location = module.resource_group.resource_group_location
  resource_group_name     = module.resource_group.resource_group_name
  address_space           = ["10.0.0.0/16"]
}

# Create a subnet

module "subnet" {
  source               = "./modules/subnet"
  resource_group_name  = module.resource_group.resource_group_name
  virtual_network_name = module.vnet.virtual_network_name
  address_prefixes     = ["10.0.1.0/24"]
}

# Create a network security group

module "nsg" {
  source              = "./modules/nsg"
  prefix              = var.prefix
  location            = module.resource_group.resource_group_location
  resource_group_name = module.resource_group.resource_group_name
  security_rules = [
    {
      name                       = "SSH"
      priority                   = 1001
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "3389"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
  }]
}

module "public_ip" {
  source              = "./modules/public-ip"
  prefix              = var.prefix
  location            = module.resource_group.resource_group_location
  resource_group_name = module.resource_group.resource_group_name
  allocation_method   = "Dynamic"

}

# Create a network interface

module "nic" {
  source               = "./modules/nic"
  prefix               = var.prefix
  location             = module.resource_group.resource_group_location
  resource_group_name  = module.resource_group.resource_group_name
  subnet_id            = module.subnet.subnet_id
  public_ip_address_id = module.public_ip.id
}

#Create a network security group association

module "nsg_association" {
  source                    = "./modules/nsg-association"
  network_interface_id      = module.nic.id
  network_security_group_id = module.nsg.id
}

# Create a virtual machine
resource "azurerm_virtual_machine" "vm" {
  name                  = "${var.prefix}-vm"
  location              = module.resource_group.resource_group_location
  resource_group_name   = module.resource_group.resource_group_name
  network_interface_ids = [module.nic.id]
  vm_size               = "Standard_DS1_v2"

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04.0-LTS"
    version   = "latest"
  }

  storage_os_disk {
    name              = "${var.prefix}-osdisk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Premium_LRS"
  }

  os_profile {
    computer_name  = "${var.prefix}-vm"
    admin_username = "adminuser"
    admin_password = "Password1234!"
  }


}
