output "name" {
  value = azurerm_private_endpoint.private_endpoint.name

}

output "id" {
  value = azurerm_private_endpoint.private_endpoint.id
}


output "private_ip_address" {
  value = azurerm_private_endpoint.private_endpoint.subnet_id
}
