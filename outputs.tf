output "vm_name" {
  value = azurerm_linux_virtual_machine.vm.name

}

output "vm_ip_address" {
  value = var.public_ip ? module.public_ip[0].ip_address : azurerm_linux_virtual_machine.vm.private_ip_address

}

output "ssh_key" {
  value = tls_private_key.key.private_key_openssh
}

output "username" {
  value = var.username
}
