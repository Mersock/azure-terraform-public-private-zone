output "vnet_id" {
  description = "VNET OD"
  value       = azurerm_virtual_network.this.id
}

output "vnet_name" {
  description = "Name VNET"
  value       = azurerm_virtual_network.this.name
}

output "group_a_subnet_id" {
  description = "ID group A subnet"
  value       = azurerm_subnet.group_a.id
}

output "group_a_subnet_name" {
  description = "Name group A subnet"
  value       = azurerm_subnet.group_a.name
}

output "group_a_subnet_cidr" {
  description = "CIDR range group A subnet"
  value       = var.group_a_subnet_cidr
}

output "group_b_subnet_id" {
  description = "ID of the group B subnet"
  value       = azurerm_subnet.group_b.id
}

output "group_b_subnet_name" {
  description = "Name of the Group B subnet"
  value       = azurerm_subnet.group_b.name
}

output "group_b_subnet_cidr" {
  description = "CIDR range group B subnet"
  value       = var.group_b_subnet_cidr
}

output "app_gateway_subnet_id" {
  description = "ID app gateway subnet"
  value       = azurerm_subnet.app_gateway.id
}

output "app_gateway_subnet_name" {
  description = "Name app gateway subnet"
  value       = azurerm_subnet.app_gateway.name
}

output "app_gateway_subnet_cidr" {
  description = "CIDR app gateway subnet"
  value       = var.app_gateway_subnet_cidr
}

output "bastion_subnet_id" {
  description = "ID Azure Bastion subnet"
  value       = azurerm_subnet.bastion.id
}

output "bastion_subnet_name" {
  description = "Name Azure Bastion subnet"
  value       = azurerm_subnet.bastion.name
}

output "bastion_subnet_cidr" {
  description = "CIDR range Azure Bastion subnet."
  value       = var.bastion_subnet_cidr
}

output "group_a_subnet_address_prefix" {
  value = azurerm_subnet.group_a.address_prefixes[0]
}

output "group_b_subnet_address_prefix" {
  value = azurerm_subnet.group_b.address_prefixes[0]
}

output "app_gateway_subnet_address_prefix" {
  value = azurerm_subnet.app_gateway.address_prefixes[0]
}

output "bastion_subnet_address_prefix" {
  value = azurerm_subnet.bastion.address_prefixes[0]
}