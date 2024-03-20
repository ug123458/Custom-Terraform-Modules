variable "name" {
  default = "my-vnet"
}

variable "address_space" {
  type    = list(string)
  default = ["10.0.0.0/16"]
}

variable "resource_group_name" {
  default = "my-rg"
}

variable "resource_group_location" {
}