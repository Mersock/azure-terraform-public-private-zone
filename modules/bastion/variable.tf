variable "resource_group_name" {
  description = "name resource group"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "bastion_name" {
  description = "Name Azure Bastion host"
  type        = string
}

variable "bastion_public_ip_name" {
  description = "Public IP Azure Bastion"
  type        = string
}

variable "bastion_subnet_id" {
  description = "ID AzureBastionSubnet"
  type        = string
}