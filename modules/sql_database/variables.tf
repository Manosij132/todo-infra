
variable "databases" {
  type = map(object({

    name      = string
    sku_name  = optional(string)
    max_size_gb = optional(number)
    collation   = optional(string)
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
