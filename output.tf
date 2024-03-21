output "function_app_default_hostname" {
  description = "The default hostname of the Function App"
  value       = azurerm_linux_function_app.example.default_hostname
}

output "sql_server_fqdn" {
  description = "The fully qualified domain name of the SQL Server"
  value       = azurerm_mssql_server.example.fully_qualified_domain_name
}

output "private_endpoint_private_ip_address" {
  description = "The private IP address of the private endpoint"
  value       = module.private_endpoint.private_ip_address
}
