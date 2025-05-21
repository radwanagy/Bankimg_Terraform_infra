variable "resource_group_name" {
  description = "name of resource"
  type        = string
  default     = "banking-resource-group"
}

variable "location" {
  description = "name of location"
  type        = string
  default     = "East US"
}

variable "storage_account_name" {
  description ="name of storage account"
  type        = string
  default     = "bankinguniquestorage1234"
}

variable "sql_admin_user" {
  description = "name of admin user"
  type        = string
  default     = "radwa"
}

variable "sql_admin_password" {
  description = "password of sql server"
  type        = string
  sensitive   = true
  default     = ""
}

variable "sql_server_name" {
  description = "name of sql server "
  type        = string
  default     = "banking-sql-server"
}

variable "sql_database_name" {
  description = "name of sql database"
  type        = string
  default     = "bankingdb"
}
variable "container_name" {
  description = "Name of the Blob container"
  type        = string
  default ="bankingcontainer"
}
variable "client_ips" {
  description = "List of public IP addresses to whitelist for SQL access"
  type        = list(string)
}


variable "enable_azure_services_access" {
  description = "Enable access to SQL Server from Azure services (e.g., Power BI)"
  type        = bool
  default     = true
}


