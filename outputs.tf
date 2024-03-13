output "vm_name" {
  value = azurerm_virtual_machine.vm.name

}

output "vm_ip_address" {
  value = module.public_ip.ip_address

}

output "ssh_key" {
  value = tls_private_key.key.private_key_openssh
}
