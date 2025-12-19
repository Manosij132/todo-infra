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

    default_outbound_access_enabled             = optional(bool)
    private_endpoint_network_policies           = optional(string)
    private_link_service_network_policies_enabled = optional(bool)
    sharing_scope                               = optional(string)
    service_endpoints                           = optional(list(string))
    service_endpoint_policy_ids                 = optional(list(string))

    delegation = optional(list(object({
      name = string

      service_delegation = object({
        name    = string
        actions = list(string)
      })
    })))
  }))
}
