resource "azurerm_subnet" "this" {
  for_each = var.subnets

  name                 = each.value.name
  resource_group_name  = each.value.resource_group_name
  virtual_network_name = each.value.virtual_network_name

  # One of these must be provided
  address_prefixes = each.value.address_prefixes
  #ip_address_pool  = each.value.ip_address_pool

  default_outbound_access_enabled            = each.value.default_outbound_access_enabled
  private_endpoint_network_policies          = each.value.private_endpoint_network_policies
  private_link_service_network_policies_enabled = each.value.private_link_service_network_policies_enabled
  sharing_scope                              = each.value.sharing_scope
  service_endpoints                          = each.value.service_endpoints
  service_endpoint_policy_ids                = each.value.service_endpoint_policy_ids

  # ----------- Delegations -----------
  dynamic "delegation" {
    for_each = each.value.delegation == null ? [] : each.value.delegation
    content {
      name = delegation.value.name

      dynamic "service_delegation" {
        for_each = [delegation.value.service_delegation]
        content {
          name    = service_delegation.value.name
          actions = service_delegation.value.actions
        }
      }
    }
  }
}
