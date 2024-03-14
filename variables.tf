variable "prefix" {
  default = "Utkarsh"
}

variable "location" {
  default = "eastus"
}

variable "username" {
  default = "admin"
}

variable "vnet_address_space" {
  default = ["10.0.0.0/16"]
  type    = list(string)
}

variable "subnet_address_prefix" {
  default = ["10.0.0.0/24"]
  type    = list(string)
}

variable "security_rules" {
  default = [
    {
      name                       = "SSH"
      priority                   = 1001
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "22"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
  }]
  type = list(object({
    name                       = string
    priority                   = number
    direction                  = string
    access                     = string
    protocol                   = string
    source_port_range          = string
    destination_port_range     = string
    source_address_prefix      = string
    destination_address_prefix = string
  }))
}
