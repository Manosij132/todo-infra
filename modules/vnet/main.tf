resource "azurerm_virtual_network" "this" {
  for_each = var.vnets

  name                = each.value.name
  resource_group_name = each.value.resource_group_name
  location            = each.value.location

  # One of these must be provided
  address_space   = each.value.address_space
 # ip_address_pool = each.value.ip_address_pool

  dns_servers                     = each.value.dns_servers
  bgp_community                   = each.value.bgp_community
  edge_zone                       = each.value.edge_zone
  flow_timeout_in_minutes         = each.value.flow_timeout_in_minutes
  private_endpoint_vnet_policies  = each.value.private_endpoint_vnet_policies
  tags                            = each.value.tags

  # ----------- DDOS BLOCK -----------
  dynamic "ddos_protection_plan" {
    for_each = each.value.ddos_protection_plan == null ? [] : [each.value.ddos_protection_plan]
    content {
      id     = ddos_protection_plan.value.id
      enable = ddos_protection_plan.value.enable
    }
  }

  # ----------- ENCRYPTION BLOCK -----------
  dynamic "encryption" {
    for_each = each.value.encryption == null ? [] : [each.value.encryption]
    content {
      enforcement = encryption.value.enforcement
    }
  }
}
