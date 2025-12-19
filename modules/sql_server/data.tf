data "azurerm_key_vault" "kv" {
  name                = var.kvname
  resource_group_name = var.kvrg
}

data "azurerm_key_vault_secret" "sqlid" {
  name         = var.sqlid
  key_vault_id = data.azurerm_key_vault.kv.id
}

data "azurerm_key_vault_secret" "sqlpw" {
  name         = var.sqlpw
  key_vault_id = data.azurerm_key_vault.kv.id
}
