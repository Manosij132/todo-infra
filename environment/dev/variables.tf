variable "rgs" {
  type = map(object(
    {
      name       = string
      location   = string
      managed_by = optional(string)
      tags       = optional(map(string))
    }
  ))
}

variable "subnets" {
  type = map(object({
    name                 = string
    resource_group_name  = string
    virtual_network_name = string

    # Exactly one is required
    address_prefixes = optional(list(string))
    ip_address_pool = optional(list(object({
      id                     = string
      number_of_ip_addresses = string
    })))

    default_outbound_access_enabled               = optional(bool)
    private_endpoint_network_policies             = optional(string)
    private_link_service_network_policies_enabled = optional(bool)
    sharing_scope                                 = optional(string)
    service_endpoints                             = optional(list(string))
    service_endpoint_policy_ids                   = optional(list(string))

    delegation = optional(list(object({
      name = string

      service_delegation = object({
        name    = string
        actions = list(string)
      })
    })))
  }))
}

variable "vnets" {
  type = map(object({
    name                = string
    resource_group_name = string
    location            = string

    address_space = optional(list(string))
    ip_address_pool = optional(list(object({
      id                     = string
      number_of_ip_addresses = string
    })))

    dns_servers   = optional(list(string))
    bgp_community = optional(string)

    ddos_protection_plan = optional(object({
      id     = string
      enable = bool
    }))

    encryption = optional(object({
      enforcement = string
    }))

    edge_zone                      = optional(string)
    flow_timeout_in_minutes        = optional(number)
    private_endpoint_vnet_policies = optional(string)

    tags = optional(map(string))
  }))
}


variable "pips" {
  type = map(object(
    {
      name                    = string
      rg_key                  = string
      allocation_method       = string
      zones                   = optional(list(string))
      ddos_protection_mode    = optional(string)
      ddos_protection_plan_id = optional(string)
      domain_name_label       = optional(string)
      domain_name_label_scope = optional(string)
      edge_zone               = optional(string)
      idle_timeout_in_minutes = optional(string)
      ip_tags                 = optional(map(string))
      ip_version              = optional(string)
      public_ip_prefix_id     = optional(string)
      reverse_fqdn            = optional(string)
      sku                     = optional(string)
      sku_tier                = optional(string)
      tags                    = optional(map(string))
    }
  ))
}


variable "sqlservers" {
  type = map(object(
    {
      name    = string
      rg_key  = string
      version = string


      azuread_administrator = optional(object(
        {
          login_username              = string
          object_id                   = string
          tenant_id                   = string
          azuread_authentication_only = bool
        }
      ))
      connection_policy                            = optional(string)
      public_network_access_enabled                = optional(bool)
      outbound_network_restriction_enabled         = optional(string)
      minimum_tls_version                          = optional(string)
      transparent_data_encryption_key_vault_key_id = optional(string)
      express_vulnerability_assessment_enabled     = optional(bool)
      identity = optional(object({
        type         = optional(string)
        identity_ids = optional(list(string))
      }))

      primary_user_assigned_identity_id = optional(string)
      tags                              = optional(map(string))

    }
  ))
}

variable "kvname" {}
variable "kvrg" {}
variable "sqlid" {}
variable "sqlpw" {}



variable "databases" {
  type = map(object({

    name         = string
    sku_name     = optional(string)
    max_size_gb  = optional(number)
    collation    = optional(string)
    license_type = optional(string)

    # Serverless Settings
    auto_pause_delay_in_minutes = optional(number)
    min_capacity                = optional(number)

    # Replication / Pooling
    zone_redundant     = optional(bool)
    read_replica_count = optional(number)
    read_scale         = optional(bool)
    elastic_pool_id    = optional(string)

    # Create / Restore Mode
    create_mode                 = optional(string)
    creation_source_database_id = optional(string)
    sample_name                 = optional(string)

    # Encryption / TDE
    transparent_data_encryption_enabled                        = optional(bool)
    transparent_data_encryption_key_vault_key_id               = optional(string)
    transparent_data_encryption_key_automatic_rotation_enabled = optional(bool)

    enclave_type = optional(string)

    # IMPORT BLOCK
    import = optional(object({
      storage_uri                  = string
      storage_key                  = string
      storage_key_type             = string
      administrator_login          = string
      administrator_login_password = string
      authentication_type          = string
      storage_account_id           = optional(string)
    }))

    # MANAGED IDENTITY
    identity = optional(object({
      type         = string
      identity_ids = optional(list(string))
    }))

    # SHORT TERM RETENTION
    short_term_retention = optional(object({
      retention_days           = number
      backup_interval_in_hours = optional(number)
    }))

    # THREAT DETECTION
    threat_detection_policy = optional(object({
      state                      = string
      disabled_alerts            = optional(list(string))
      email_account_admins       = optional(bool)
      email_addresses            = optional(list(string))
      retention_days             = optional(number)
      storage_endpoint           = optional(string)
      storage_account_access_key = optional(string)
    }))

    # LONG TERM RETENTION
    long_term_retention = optional(object({
      weekly_retention  = string
      monthly_retention = string
      yearly_retention  = string
      week_of_year      = optional(number)
    }))

    tags = optional(map(string))
  }))
}


variable "sqlserver" {}
variable "rgname" {}


variable "vms" {
  type = map(object({
    name                = string
    resource_group_name = optional(string)
    location            = optional(string)
    rg_key              = optional(string)
    size                = string
    subnet              = string
    vnet                = string
    pip                 = string

    # ---------- NIC BLOCK ----------
    nic = object({
      name = string
      ip_config = object({
        name                          = string
        subnet_id                     = optional(string)
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

# variable "rg_details" {
#   type = map(object(
#     {
#       name      = string
#       location = string
#     }
#   ))
# }

variable "vmid" {}
variable "vmpw" {}
