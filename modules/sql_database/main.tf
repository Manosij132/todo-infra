
###############################################
# RESOURCE: SQL DATABASE
###############################################
resource "azurerm_mssql_database" "this" {
  for_each = var.databases

  name      = each.value.name
  server_id = data.azurerm_mssql_server.sqlsv.id

  # BASIC SETTINGS
  sku_name     = each.value.sku_name
  max_size_gb  = each.value.max_size_gb
  collation    = each.value.collation
  license_type = each.value.license_type

  # SERVERLESS SETTINGS
  auto_pause_delay_in_minutes = each.value.auto_pause_delay_in_minutes
  min_capacity                = each.value.min_capacity

  # HIGH AVAILABILITY / REPLICAS
  zone_redundant     = each.value.zone_redundant
  read_replica_count = each.value.read_replica_count
  read_scale         = each.value.read_scale
  elastic_pool_id    = each.value.elastic_pool_id

  # RESTORE / COPY / SAMPLE
  create_mode                 = each.value.create_mode
  creation_source_database_id = each.value.creation_source_database_id
  sample_name                 = each.value.sample_name

  # TDE (Encryption)
  transparent_data_encryption_enabled                        = each.value.transparent_data_encryption_enabled
  transparent_data_encryption_key_vault_key_id               = each.value.transparent_data_encryption_key_vault_key_id
  transparent_data_encryption_key_automatic_rotation_enabled = each.value.transparent_data_encryption_key_automatic_rotation_enabled

  # SIMPLE ARGUMENT (not block)
  enclave_type = each.value.enclave_type

  tags = each.value.tags

  ###############################################
  # DYNAMIC BLOCKS
  ###############################################

  # IMPORT BLOCK
  dynamic "import" {
    for_each = each.value.import != null ? [each.value.import] : []
    content {
      storage_uri                  = import.value.storage_uri
      storage_key                  = import.value.storage_key
      storage_key_type             = import.value.storage_key_type
      administrator_login          = import.value.administrator_login
      administrator_login_password = import.value.administrator_login_password
      authentication_type          = import.value.authentication_type
      storage_account_id           = import.value.storage_account_id
    }
  }

  # MANAGED IDENTITY BLOCK
  dynamic "identity" {
    for_each = each.value.identity != null ? [each.value.identity] : []
    content {
      type         = identity.value.type
      identity_ids = identity.value.identity_ids
    }
  }

  # SHORT TERM RETENTION POLICY
  dynamic "short_term_retention_policy" {
    for_each = each.value.short_term_retention != null ? [each.value.short_term_retention] : []
    content {
      retention_days           = short_term_retention_policy.value.retention_days
      backup_interval_in_hours = short_term_retention_policy.value.backup_interval_in_hours
    }
  }

  # THREAT DETECTION POLICY
  dynamic "threat_detection_policy" {
    for_each = each.value.threat_detection_policy != null ? [each.value.threat_detection_policy] : []
    content {
      state                      = threat_detection_policy.value.state
      disabled_alerts            = threat_detection_policy.value.disabled_alerts
      email_account_admins       = threat_detection_policy.value.email_account_admins
      email_addresses            = threat_detection_policy.value.email_addresses
      retention_days             = threat_detection_policy.value.retention_days
      storage_endpoint           = threat_detection_policy.value.storage_endpoint
      storage_account_access_key = threat_detection_policy.value.storage_account_access_key
    }
  }

  # LONG TERM RETENTION POLICY
  dynamic "long_term_retention_policy" {
    for_each = each.value.long_term_retention != null ? [each.value.long_term_retention] : []
    content {
      weekly_retention  = long_term_retention_policy.value.weekly_retention
      monthly_retention = long_term_retention_policy.value.monthly_retention
      yearly_retention  = long_term_retention_policy.value.yearly_retention
      week_of_year      = long_term_retention_policy.value.week_of_year
    }
  }
}

