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

variable "rg_details" {
  type = map(object(
    {
      name     = string
      location = string
    }
  ))
}
