variable "name" {
  default = "my-subnet"
}

variable "address_prefixes" {
  type    = list(string)
  default = ["10.0.0.0/24"]
}

variable "resource_group_name" {
  default = "my-rg"
}

variable "virtual_network_name" {
  default = "my-vnet"
}