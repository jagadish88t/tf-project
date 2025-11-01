variable "rg_name" {
  type = string
  description = "Resource group name where the resources are going to be created."
}

variable "env" {
  type        = string
  description = "Environment in which resource to be created."
}

variable "proj_acro" {
  type        = string
  description = "Project acronym used for naming resources created for specific project."
}

variable "address_space" {
  type        = list(string)
  description = " (Required) The address space that is used the virtual network. You can supply more than one address space."
}

variable "subnet_config" {
  type = map(object({
    address_prefixes = string
    service_delegation = optional(object({
      service_name    = string
      service_actions = list(string)
    }))
    private_endpoint_network_policies = optional(string)
    service_endpoints                 = optional(list(string))
    default_outbound_access           = optional(bool)
  }))
  description = " (Required) The address space that is used the virtual network. You can supply more than one address space."
}

variable "tags" {
  description = "(Required) Mandatory tags for resources to be created in Azure."
  type = object({
    customerid      = string
    project     = string
    application = string
    environment     = string
    management      = string
  })
}

variable "resource_type" {
  type        = string
  description = "Resource type whether it is vm, app or aks."
}

