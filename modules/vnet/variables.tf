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

    dns_servers    = optional(list(string))
    bgp_community  = optional(string)

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
