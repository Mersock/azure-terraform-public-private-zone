module "resource_group" {
  source = "./modules/resource_group"

  name     = var.resource_group_name
  location = var.location

  tags = var.tags
}

module "network" {
  source = "./modules/network"

  name_prefix         = var.name_prefix
  location            = module.resource_group.location
  resource_group_name = module.resource_group.name

  vnet_address_space      = ["10.10.0.0/16"]
  group_a_subnet_cidr     = "10.10.1.0/24"
  group_b_subnet_cidr     = "10.10.2.0/24"
  app_gateway_subnet_cidr = "10.10.3.0/24"
  bastion_subnet_cidr     = "10.10.4.0/26"
}

module "nsg" {
  source = "./modules/nsg"

  project_name        = var.project_name
  location            = module.resource_group.location
  resource_group_name = module.resource_group.name

  group_a_subnet_id = module.network.group_a_subnet_id
  group_b_subnet_id = module.network.group_b_subnet_id

  group_a_subnet_address_prefix     = module.network.group_a_subnet_address_prefix
  group_b_subnet_address_prefix     = module.network.group_b_subnet_address_prefix
  app_gateway_subnet_address_prefix = module.network.app_gateway_subnet_address_prefix
  bastion_subnet_address_prefix     = module.network.bastion_subnet_address_prefix

  tags = var.tags
}

module "bastion" {
  source = "./modules/bastion"

  resource_group_name    = module.resource_group.name
  location               = module.resource_group.location
  bastion_name           = "bas-${var.project_name}"
  bastion_public_ip_name = "pip-bas-${var.project_name}"
  bastion_subnet_id      = module.network.bastion_subnet_id
}

module "compute" {
  source = "./modules/compute"

  name_prefix         = var.name_prefix
  location            = module.resource_group.location
  resource_group_name = module.resource_group.name

  group_a_subnet_id = module.network.group_a_subnet_id
  group_b_subnet_id = module.network.group_b_subnet_id

  admin_username        = var.admin_username
  admin_ssh_public_keys = var.admin_ssh_public_keys

  tags = var.tags

  depends_on = [
    module.nsg,
    module.bastion
  ]
}