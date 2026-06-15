variable "name_prefix" {
  description = "Name prefix compute"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "resource_group_name" {
  description = "Resource group name"
  type        = string
}

variable "group_a_subnet_id" {
  description = "Subnet ID Group A VMs"
  type        = string
}

variable "group_b_subnet_id" {
  description = "Subnet ID Group B VMs"
  type        = string
}

variable "admin_username" {
  description = "Admin username Linux VMs"
  type        = string
}

variable "admin_ssh_public_keys" {
  description = "List SSH public keys Azure Bastion"
  type        = list(string)
}

variable "group_a_vm_size" {
  description = "Memory VM size Group A"
  type        = string
  default     = "Standard_B2ms"
}

variable "group_b_vm_size" {
  description = "CPU VM size Group B"
  type        = string
  default     = "Standard_B1ms"
}

variable "tags" {
  description = "Tags for compute resources"
  type        = map(string)
  default     = {}
}