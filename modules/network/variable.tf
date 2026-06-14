variable "name_prefix" {
  description = "network resource names"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "resource_group_name" {
  description = "name resource group"
  type        = string
}

variable "vnet_address_space" {
  description = "VNET Address space"
  type        = list(string)
  default     = ["10.10.0.0/16"]
}

variable "group_a_subnet_cidr" {
  description = "CIDR range group A subnet"
  type        = string
  default     = "10.10.1.0/24"
}

variable "group_b_subnet_cidr" {
  description = "CIDR range Group B subnet"
  type        = string
  default     = "10.10.2.0/24"
}

variable "app_gateway_subnet_cidr" {
  description = "CIDR range for Application Gateway subnet."
  type        = string
  default     = "10.10.3.0/24"
}

variable "bastion_subnet_cidr" {
  description = "CIDR range for Azure Bastion subnet."
  type        = string
  default     = "10.10.4.0/26"
}