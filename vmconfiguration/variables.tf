/*
  Required variables to create Azure Web App.
*/

variable "tenant_id" {
  description = "(Required) Tenant Id"
  type        = string
}

variable "user_object_id" {
  description = "User object id."
  type        = string
}

variable "proj_acro" {
  description = "(Required) project acronym used to create resource group."
  type        = string
  nullable    = false
}

variable "env" {
  description = "(Required) Environment in which resource to be created."
  type        = string
  nullable    = false
}

variable "subnet_config" {
  description = "(Required) Subnet configuration."
  type = map(object({
    address_prefixes = string
    service_delegation = optional(object({
      service_name    = string
      service_actions = list(string)
    }))
    default_outbound_access               = optional(bool)
    private_link_service_network_policies = optional(bool)
    private_endpoint_network_policies     = optional(string)
    service_endpoints                     = optional(list(string))
    service_endpoint_policy_ids           = optional(list(string))
  }))
  default = {}
}


variable "address_space" {
  description = " (Required) The address space that is used the virtual network. You can supply more than one address space."
  type        = list(string)
}

variable "tags" {
  description = "(Required) Mandatory tags for resources to be created in Azure."
  type = object({
    customerid  = string
    project     = string
    application = string
    environment = string
    management  = string
  })
}

variable "resource_type" {
  description = "(Required) Resource code to form virtual network name."
  type        = string
}

variable "nsg_rules" {
  description = "(Required) Network security rules to be assigned to Subnets."
  type = map(object({
    name                       = string
    priority                   = string
    direction                  = string
    access                     = string
    protocol                   = string
    source_port_range          = string
    destination_port_range     = string
    source_address_prefix      = string
    destination_address_prefix = string
  }))
  default = {}
}

/*
  Optional variables.
*/

variable "nsg_name" {
  type        = string
  description = "(Optional) Network security group name."
  default     = null
}

variable "vnet_name" {
  type        = string
  description = "(Optional) Virtual network name."
  default     = null
}

variable "az_region" {
  description = "(Optional) Azure region where the resources are going to be created."
  type        = string
  default     = "eastus"
  validation {
    condition     = contains(["eastus"], lower(var.az_region))
    error_message = "Unsupported Azure region specified. Supported region is eastus."
  }
}

variable "it_num" {
  description = "(Optional) Trailing id used for resource name."
  type        = string
  default     = "101"
}


