resource "azurerm_mssql_server" "sqlserver" {
  name                         = var.sql_server_name
  resource_group_name          = azurerm_resource_group.rg.name
  location                     = var.location
  version                      = "12.0"
  administrator_login          = var.sql_admin_user
  administrator_login_password = var.sql_admin_password

  public_network_access_enabled = true
}

# Enable Allow Azure Service and Resource to access this server for powerbi

resource "azurerm_mssql_firewall_rule" "allow_azure_services" {
  name             = "AllowAzureServices"
  server_id        = azurerm_mssql_server.sqlserver.id
  start_ip_address = "0.0.0.0"
  end_ip_address   = "0.0.0.0"
}

# Whitless Client ips via Azure 
resource "azurerm_mssql_firewall_rule" "allowed_ips" {
  for_each = toset(var.allowed_ips)

  name             = "AllowIP-${replace(each.key, ".", "-")}"
  server_id        = azurerm_mssql_server.sqlserver.id
  start_ip_address = each.value
  end_ip_address   = each.value
}
