resource "azurerm_network_interface" "this" {
  for_each = var.vms

  name                = each.value.nic.name
  location            = var.rg_details[each.value.rg_key].location
  resource_group_name = var.rg_details[each.value.rg_key].name

  dynamic "ip_configuration" {
    for_each = each.value.nic.ip_config == null ? [] : [each.value.nic.ip_config]

    content {
      name                          = ip_configuration.value.name
      subnet_id                     = data.azurerm_subnet.subnet[each.key].id
      private_ip_address_allocation = ip_configuration.value.private_ip_address_allocation
      private_ip_address            = ip_configuration.value.private_ip_address
      public_ip_address_id          = ip_configuration.value.public_ip_address_id
    }
  }
}

resource "azurerm_linux_virtual_machine" "this" {
  for_each = var.vms

  name                  = each.value.name
  resource_group_name   = var.rg_details[each.value.rg_key].name
  location              = var.rg_details[each.value.rg_key].location
  size                  = each.value.size
   network_interface_ids = [azurerm_network_interface.this[each.key].id]

  # OPTIONAL BLOCKS
  admin_username                  = data.azurerm_key_vault_secret.kvid.value
  admin_password                  = data.azurerm_key_vault_secret.kvpw.value
  disable_password_authentication = each.value.disable_password_authentication
  computer_name                   = each.value.computer_name
  custom_data                     = each.value.custom_data
  user_data                       = each.value.user_data
  license_type                    = each.value.license_type
  allow_extension_operations      = each.value.allow_extension_operations
  provision_vm_agent              = each.value.provision_vm_agent
  eviction_policy                 = each.value.eviction_policy
  max_bid_price                   = each.value.max_bid_price
  priority                        = each.value.priority
  secure_boot_enabled             = each.value.secure_boot_enabled
  vtpm_enabled                    = each.value.vtpm_enabled
  encryption_at_host_enabled      = each.value.encryption_at_host_enabled
  proximity_placement_group_id    = each.value.proximity_placement_group_id
  zone                            = each.value.zone

  # SOURCE IMAGE
  dynamic "source_image_reference" {
    for_each = each.value.source_image_reference == null ? [] : [each.value.source_image_reference]

    content {
      publisher = source_image_reference.value.publisher
      offer     = source_image_reference.value.offer
      sku       = source_image_reference.value.sku
      version   = source_image_reference.value.version
    }
  }

  # ADMIN SSH KEY
  dynamic "admin_ssh_key" {
    for_each = each.value.admin_ssh_key == null ? [] : each.value.admin_ssh_key

    content {
      username   = admin_ssh_key.value.username
      public_key = admin_ssh_key.value.public_key
    }
  }

  # OS DISK
  dynamic "os_disk" {
    for_each = each.value.os_disk == null ? [] : [each.value.os_disk]

    content {
      caching              = os_disk.value.caching
      storage_account_type = os_disk.value.storage_account_type
      disk_size_gb         = os_disk.value.disk_size_gb
      name                 = os_disk.value.name
    }
  }

  # BOOT DIAGNOSTICS
  dynamic "boot_diagnostics" {
    for_each = each.value.boot_diagnostics == null ? [] : [each.value.boot_diagnostics]

    content {
      storage_account_uri = boot_diagnostics.value.storage_account_uri
    }
  }

  # IDENTITY
  dynamic "identity" {
    for_each = each.value.identity == null ? [] : [each.value.identity]

    content {
      type         = identity.value.type
      identity_ids = identity.value.identity_ids
    }
  }

  tags = each.value.tags
}




