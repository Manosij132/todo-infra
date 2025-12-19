resource "azurerm_public_ip" "pip" {
  for_each            = var.pips
  name                = each.value.name
  resource_group_name = var.rg_details[each.value.rg_key].name
  location            = var.rg_details[each.value.rg_key].location

  # Required field — Static or Dynamic
  allocation_method = each.value.allocation_method

  # Optional: Availability Zone support (only for Standard SKU)
  zones = each.value.zones

  # Optional: DDoS Protection settings
  ddos_protection_mode    = each.value.ddos_protection_mode    # Possible: Disabled, Enabled, VirtualNetworkInherited
  ddos_protection_plan_id = each.value.ddos_protection_plan_id # Uncomment if mode=Enabled

  # Optional: DNS domain label
  domain_name_label       = each.value.domain_name_label
  domain_name_label_scope = each.value.domain_name_label_scope # Possible: NoReuse, ResourceGroupReuse, SubscriptionReuse, TenantReuse

  # Optional: Edge Zone (if your region supports it)
  edge_zone = each.value.edge_zone

  # Optional: Idle connection timeout (default 4, max 30)
  idle_timeout_in_minutes = each.value.idle_timeout_in_minutes

  # Optional: IP tags (requires Standard SKU)
  ip_tags = each.value.ip_tags

  # Optional: IP version (IPv4 / IPv6)
  ip_version = each.value.ip_version

  # Optional: Public IP prefix association
  public_ip_prefix_id = each.value.public_ip_prefix_id

  # Optional: Reverse DNS (PTR record)
  reverse_fqdn = each.value.reverse_fqdn

  # SKU configuration
  sku      = each.value.sku      # Accepted: Basic, Standard
  sku_tier = each.value.sku_tier # Accepted: Regional, Global (Global requires Standard SKU)

  # Tags for resource management
  tags = each.value.tags
}
