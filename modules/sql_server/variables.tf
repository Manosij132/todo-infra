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

variable "rg_details" {
  type = map(object(
    {
      name     = string
      location = string
    }
  ))
}
