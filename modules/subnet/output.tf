output "subnet_ids" {
  value = { for k, v in azurerm_subnet.this : k => v.id }
}

output "subnet_names" {
  value = { for k, v in azurerm_subnet.this : k => v.name }
}

output "subnet_prefixes" {
  value = { for k, v in azurerm_subnet.this : k => v.address_prefixes }
}
