data "azurerm_mssql_server" "sqlsv" {
  name                = var.sqlserver
  resource_group_name = var.rgname
}
