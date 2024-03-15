module "resource_group" {
  source   = "./modules/resource-group"
  prefix   = var.prefix
  location = var.location
}

# Create a virtual network

module "vnet" {
  source                  = "./modules/vnet"
  resource_group_location = module.resource_group.resource_group_location
  resource_group_name     = module.resource_group.resource_group_name
  address_space           = var.vnet_address_space
}

# Create a subnet

module "subnet" {
  source               = "./modules/subnet"
  resource_group_name  = module.resource_group.resource_group_name
  virtual_network_name = module.vnet.virtual_network_name
  address_prefixes     = var.subnet_address_prefix
}

# Create a network security group

module "nsg" {
  source              = "./modules/nsg"
  prefix              = var.prefix
  location            = module.resource_group.resource_group_location
  resource_group_name = module.resource_group.resource_group_name
  security_rules      = var.security_rules
}

module "public_ip" {
  source              = "./modules/public-ip"
  prefix              = var.prefix
  location            = module.resource_group.resource_group_location
  resource_group_name = module.resource_group.resource_group_name
  allocation_method   = "Static"
  count               = var.public_ip ? 1 : 0

}

# Create a network interface

module "nic" {
  source               = "./modules/nic"
  prefix               = var.prefix
  location             = module.resource_group.resource_group_location
  resource_group_name  = module.resource_group.resource_group_name
  subnet_id            = module.subnet.subnet_id
  public_ip_address_id = module.public_ip.id ? module.public_ip.id : null
}

#Create a network security group association

module "nsg_association" {
  source                    = "./modules/nsg-association"
  network_interface_id      = module.nic.id
  network_security_group_id = module.nsg.id
}

resource "tls_private_key" "key" {
  algorithm = "RSA"
  rsa_bits  = 4096

}



# Create a virtual machine
resource "azurerm_linux_virtual_machine" "vm" {
  name                  = "${var.prefix}-vm"
  location              = module.resource_group.resource_group_location
  resource_group_name   = module.resource_group.resource_group_name
  network_interface_ids = [module.nic.id]
  size                  = "Standard_DS1_v2"
  admin_username        = var.username

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  admin_ssh_key {
    username   = var.username
    public_key = tls_private_key.key.public_key_openssh
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}
