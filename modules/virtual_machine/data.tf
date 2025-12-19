data "azurerm_key_vault" "kv" {
  name                = var.kvname
  resource_group_name = var.kvrg
}

data "azurerm_key_vault_secret" "kvid" {
  name         = var.vmid
  key_vault_id = data.azurerm_key_vault.kv.id
}

data "azurerm_key_vault_secret" "kvpw" {
  name         = var.vmpw
  key_vault_id = data.azurerm_key_vault.kv.id
}

data "azurerm_subnet" "subnet" {
  for_each = var.vms
  name                 = each.value.subnet
  virtual_network_name = each.value.vnet
  resource_group_name  = var.rg_details[each.value.rg_key].name
}

data "azurerm_public_ip" "pip" {
  for_each = var.vms
  name                = each.value.pip
  resource_group_name = var.rg_details[each.value.rg_key].name
}