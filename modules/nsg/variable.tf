variable "project_name" {
  type = string
}

variable "location" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "group_a_subnet_id" {
  type = string
}

variable "group_b_subnet_id" {
  type = string
}

variable "group_a_subnet_address_prefix" {
  type = string
}

variable "group_b_subnet_address_prefix" {
  type = string
}

variable "app_gateway_subnet_address_prefix" {
  type = string
}

variable "bastion_subnet_address_prefix" {
  type = string
}

variable "tags" {
  type    = map(string)
  default = {}
}