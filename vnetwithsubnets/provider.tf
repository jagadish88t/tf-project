module "provider" {
  source = "git::https://github.com/jagadish88t/tf-modules.git//provider?ref=main"
}

terraform {
  backend "local" {}
}

provider "azurerm" {
  features {}
  subscription_id = ""
  resource_provider_registrations = "none"
}