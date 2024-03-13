output "vm_name" {
  value = azurerm_virtual_machine.vm.name

}

output "vm_ip_address" {
  value = module.public_ip.ip_address

}
