rg_name = ""
proj_acro     = "jt"
env           = "poc"
address_space = ["10.0.0.0/16"]
subnet_config = {
  "subnet1" = {
    address_prefixes = "10.0.1.0/24"
    service_delegation = {
      service_name = "Microsoft.Sql/managedInstances"
      service_actions = [
        "Microsoft.Network/virtualNetworks/subnets/join/action",
        "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action",
        "Microsoft.Network/virtualNetworks/subnets/unprepareNetworkPolicies/action"
      ]
    }
    private_endpoint_network_policies = "Enabled"
    service_endpoints                 = ["Microsoft.Storage", "Microsoft.Sql"]
    default_outbound_access           = true
  },
  "subnet2" = {
    address_prefixes = "10.0.2.0/24"
    service_delegation = {
      service_name = "Microsoft.Sql/managedInstances"
      service_actions = [
        "Microsoft.Network/virtualNetworks/subnets/join/action"
      ]
    }
    # private_endpoint_network_policies = "Disabled"
  }
}

tags = {
  customerid      = "jt"
  environment     = "POC"
  management      = "Terraform"
  application = "test"
  project     = "TF"
}

resource_type     = "vm"
