output "name" {
  value = azurerm_storage_account.storage_account.name

}

output "id" {
  value = azurerm_storage_account.storage_account.id
}

output "access_key" {
  value = azurerm_storage_account.storage_account.primary_access_key
}
