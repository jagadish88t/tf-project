module "rg" {
  source    = "git::https://github.com/jagadish88t/tf-modules.git//resourcegroup?ref=main"
  proj_acro = var.proj_acro
  env       = var.env
  az_region = var.az_region
  it_num    = var.it_num
}