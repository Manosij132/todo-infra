resource "azurerm_mssql_server" "sql-server" {
  # -------------------------------
  # Required Properties
  # -------------------------------
  for_each            = var.sqlservers
  name                = each.value.name # Must be globally unique
  resource_group_name = var.rg_details[each.value.rg_key].name
  location            = var.rg_details[each.value.rg_key].location
  version             = each.value.version # Possible: 2.0 (v11), 12.0 (v12)

  # -------------------------------
  # Authentication (SQL Login)
  # -------------------------------
  administrator_login          = data.azurerm_key_vault_secret.sqlid.value # Required unless AAD-only auth
  administrator_login_password = data.azurerm_key_vault_secret.sqlpw.value # Must meet Azure password policy
  # administrator_login_password_wo = "SensitivePassword123!"   # (Write-only alternative)
  # administrator_login_password_wo_version = 1                 # Increment when rotating password

  # -------------------------------
  # Azure AD Administrator Configuration
  # -------------------------------
dynamic "azuread_administrator" {
  for_each = each.value.azuread_administrator == null ? [] : [each.value.azuread_administrator]

  content {
    login_username              = azuread_administrator.value.login_username
    object_id                   = azuread_administrator.value.object_id
    tenant_id                   = azuread_administrator.value.tenant_id
    azuread_authentication_only = azuread_administrator.value.azuread_authentication_only
  }
}

  # -------------------------------
  # Network and Connectivity Settings
  # -------------------------------
  connection_policy                    = each.value.connection_policy                    # Possible: Default, Proxy, Redirect
  public_network_access_enabled        = each.value.public_network_access_enabled        # false = only private endpoint access
  outbound_network_restriction_enabled = each.value.outbound_network_restriction_enabled # Restrict outbound connections (optional)

  # -------------------------------
  # Security and Encryption
  # -------------------------------
  minimum_tls_version = each.value.minimum_tls_version # TLS 1.0 / 1.1 / 1.2 / Disabled

  # Transparent Data Encryption (TDE) with Customer Managed Key
  transparent_data_encryption_key_vault_key_id = each.value.transparent_data_encryption_key_vault_key_id

  # -------------------------------
  # DDoS Protection / Express Vulnerability Assessment
  # -------------------------------
  express_vulnerability_assessment_enabled = each.value.express_vulnerability_assessment_enabled # true/false

  # -------------------------------
  # Managed Identity Configuration
  # -------------------------------
dynamic "identity" {
  for_each = each.value.identity == null ? [] : [each.value.identity]

  content {
    type         = identity.value.type
    identity_ids = identity.value.identity_ids
  }
}


  # When using a User-Assigned Identity, you must specify the primary one
  primary_user_assigned_identity_id = each.value.primary_user_assigned_identity_id

  # -------------------------------
  # Tags
  # -------------------------------
  tags = each.value.tags
}
