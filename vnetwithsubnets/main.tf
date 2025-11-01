

# module "dataimport" {
#   source = "git::https://github.com/jagadish88t/tf-modules.git//dataimport?ref=main"
#   resource_group_name = var.rg_name
# }

module "vnet" {
  source              = "git::https://github.com/jagadish88t/tf-modules.git//vnetwithsubnets?ref=main"
  resource_group_name = var.rg_name //module.dataimport.resource_group_name
  proj_acro           = var.proj_acro
  env                 = var.env
  address_space       = var.address_space
  resource_type       = var.resource_type
  subnet_config = var.subnet_config
  tags = var.tags
}