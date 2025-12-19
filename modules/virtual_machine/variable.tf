variable "vms" {
  type = map(object({
    name                = string
rg_key = optional(string)
    size                = string
    subnet              = string
    vnet                = string
    pip                 = string

    # ---------- NIC BLOCK ----------
    nic = object({
      name = string
      ip_config = object({
        name                          = string
        subnet_id                     = string
        private_ip_address_allocation = string
        private_ip_address            = optional(string)
        public_ip_address_id          = optional(string)
      })
    })

    # ---------- VM FIELDS ----------
    network_interface_ids = optional(list(string)) # not used – replaced by NIC auto bind

    admin_username                  = optional(string)
    admin_password                  = optional(string)
    disable_password_authentication = optional(bool, true)
    computer_name                   = optional(string)
    custom_data                     = optional(string)
    user_data                       = optional(string)
    license_type                    = optional(string)
    allow_extension_operations      = optional(bool, true)
    provision_vm_agent              = optional(bool, true)
    eviction_policy                 = optional(string)
    max_bid_price                   = optional(number)
    priority                        = optional(string)
    secure_boot_enabled             = optional(bool)
    vtpm_enabled                    = optional(bool)
    encryption_at_host_enabled      = optional(bool)
    proximity_placement_group_id    = optional(string)
    zone                            = optional(string)

    admin_ssh_key = optional(list(object({
      username   = string
      public_key = string
    })))

    source_image_reference = optional(object({
      publisher = string
      offer     = string
      sku       = string
      version   = string
    }))

    os_disk = optional(object({
      caching              = string
      storage_account_type = string
      disk_size_gb         = optional(number)
      name                 = optional(string)
    }))

    boot_diagnostics = optional(object({
      storage_account_uri = optional(string)
    }))

    identity = optional(object({
      type         = string
      identity_ids = optional(list(string))
    }))

    tags = optional(map(string))
  }))
}

variable "rg_details" {
  type = map(object(
    {
      name      = string
      location = string
    }
  ))
}

variable "kvname" {}
variable "kvrg" {}
variable "vmid" {}
variable "vmpw" {}
