output "sql_server_fqdn" {
  description = "SQL Server FQDN to connect to"
  value       = azurerm_sql_server.sql_server.fully_qualified_domain_name
}

output "sql_server_connection_string" {
  description = "SQL Server connection string (without DB name)"
  value       = "Server=${azurerm_sql_server.sql_server.fully_qualified_domain_name};User ID=${var.sql_admin_user};Password=${var.sql_admin_password};"
  sensitive   = true
}

output "sql_database_name" {
  description = "Name of the SQL database"
  value       = azurerm_sql_database.database.name
}

output "storage_account_name" {
  description = "Azure Storage Account name"
  value       = azurerm_storage_account.storage.name
}

output "storage_account_blob_endpoint" {
  description = "Blob endpoint for the storage account"
  value       = azurerm_storage_account.storage.primary_blob_endpoint
}

output "storage_container_name" {
  description = "Blob container name"
  value       = azurerm_storage_container.container.name
}
