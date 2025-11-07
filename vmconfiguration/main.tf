/*
  Resources to create
  1. Resource Group
  2. Vnet with 2 subnets
  3. Disk encryption set
  4. key vault 
  5. encrypted key to encrypt the managed disk
  6. Encrypted managed disk
*/
resource "random_integer" "int" {
  max = 999
  min = 100
}

locals {
  it_num = random_integer.int.result
}

data "azurerm_client_config" "current" {}

module "rg" {
  source = "git::https://github.com/jagadish88t/tf-modules.git//resourcegroup?ref=main"
  proj_acro = var.proj_acro
  az_region = var.az_region
  env = var.env
}

module "vnet" {
  source              = "git::https://github.com/jagadish88t/tf-modules.git//vnetwithnsgandsubnets?ref=main"
  resource_group_name = module.rg.name
  proj_acro           = var.proj_acro
  env                 = var.env
  address_space       = var.address_space
  resource_type       = var.resource_type
  subnet_config       = var.subnet_config
  it_num              = local.it_num
  tags                = var.tags

  //depends_on = [ module.rg ]
}

module "keyvault" {
  source              = "git::https://github.com/jagadish88t/tf-modules.git//keyvault?ref=main"
  resource_group_name = module.rg.name
  env                 = var.env
  proj_acro           = var.proj_acro
  tenant_id           = data.azurerm_client_config.current.tenant_id
  user_object_id      = data.azurerm_client_config.current.object_id
  it_num              = local.it_num
  tags                = var.tags
  purge_protection_enabled = "true"
  //depends_on = [ module.rg ]
}

resource "azurerm_role_assignment" "kv_user_access" {
  scope                = module.keyvault.id //data.azurerm_key_vault.kv.id
  role_definition_name = "Key Vault Administrator"
  principal_id         = data.azurerm_client_config.current.object_id

  depends_on = [module.keyvault]
}

module "vmdisk" {
  source              = "git::https://github.com/jagadish88t/tf-modules.git//encrypted_managed_disk?ref=main"
  resource_group_name = module.rg.name
  key_vault_id        = module.keyvault.id
  env                 = var.env
  disk_size_gb        = "128"
  proj_acro           = var.proj_acro
  disk_tag            = local.it_num
  tags                = var.tags
  network_access_policy = "AllowAll"
  depends_on = [module.keyvault, azurerm_role_assignment.kv_user_access]
}

