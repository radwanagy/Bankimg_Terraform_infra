resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_storage_account" "storage" {
  name                     = var.storage_account_name
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  is_hns_enabled           = true
}


resource "azurerm_storage_container" "container" {
  name                 = var.container_name
  storage_account_id   = azurerm_storage_account.storage.id
  container_access_type = "private"  # أو "blob" لو عاوزة تشاركي الملفات
}



resource "azurerm_sql_server" "sql_server" {
  name                         = var.sql_server_name
  resource_group_name          = azurerm_resource_group.rg.name
  location                     = azurerm_resource_group.rg.location
  version                      = "12.0"
  administrator_login          = var.sql_admin_user
  administrator_login_password = var.sql_admin_password
   minimal_tls_version          = "1.2"
}

resource "azurerm_sql_database" "database" {
  name                = var.sql_database_name
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  server_name         = azurerm_sql_server.sql_server.name
   sku_name            = "Standard"  # "Basic" لا يدعم geo-redundancy-->manuall from azure portal
  backup_short_term_retention_days = 7
}
# Firewall Rule 1 - Allow client IP
resource "azurerm_sql_firewall_rule" "client_ip_rules" {
  for_each            = toset(var.client_ips)
  name                = "AllowClientIP-${each.value}"
  resource_group_name = azurerm_sql_server.sql_server.resource_group_name
  server_name         = azurerm_sql_server.sql_server.name
  start_ip_address    = each.value
  end_ip_address      = each.value
}


# Firewall Rule 2 - Allow Azure services (conditionally)
resource "azurerm_sql_firewall_rule" "allow_azure_services" {
  count               = var.enable_azure_services_access ? 1 : 0
  name                = "AllowAzureServices"
  resource_group_name = azurerm_sql_server.sql_server.resource_group_name
  server_name         = azurerm_sql_server.sql_server.name
  start_ip_address    = "0.0.0.0"
  end_ip_address      = "0.0.0.0"
}

