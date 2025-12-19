###############################################
# OUTPUTS
###############################################
output "database_ids" {
  value = { for k, v in azurerm_mssql_database.this : k => v.id }
}

output "database_names" {
  value = { for k, v in azurerm_mssql_database.this : k => v.name }
}

