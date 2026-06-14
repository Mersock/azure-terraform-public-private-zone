module "resource_group" {
  source = "./modules/resource_group"

  name     = var.resource_group_name
  location = var.location

  tags = var.tags
}

module "network" {
  source = "./modules/network"

  name_prefix         = "terraform-public-private-zone"
  location            = module.resource_group.location
  resource_group_name = module.resource_group.name

  vnet_address_space       = ["10.10.0.0/16"]
  group_a_subnet_cidr      = "10.10.1.0/24"
  group_b_subnet_cidr      = "10.10.2.0/24"
  app_gateway_subnet_cidr  = "10.10.3.0/24"
  bastion_subnet_cidr      = "10.10.4.0/26"
}