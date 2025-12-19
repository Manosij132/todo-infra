output "rg_details" {
  value = { for k, rg in azurerm_resource_group.rg : k => {
    name     = rg.name
    location = rg.location
    }
  }
}
