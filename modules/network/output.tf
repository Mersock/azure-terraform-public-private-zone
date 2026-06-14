output "vnet_id" {
  description = "VNET ID"
  value       = azurerm_virtual_network.this.id
}

output "vnet_name" {
  description = "VNET name"
  value       = azurerm_virtual_network.this.name
}

output "group_a_subnet_id" {
  description = "Subnet ID group A"
  value       = azurerm_subnet.group_a.id
}

output "group_a_subnet_name" {
  description = "Subnet name group B"
  value       = azurerm_subnet.group_a.name
}

output "group_b_subnet_id" {
  description = "Subnet ID group B"
  value       = azurerm_subnet.group_b.id
}

output "group_b_subnet_name" {
  description = "Subnet name group B"
  value       = azurerm_subnet.group_b.name
}

output "app_gateway_subnet_id" {
  description = "Subnet ID app gateway"
  value       = azurerm_subnet.app_gateway.id
}

output "bastion_subnet_id" {
  description = "Subnet ID Azure Bastion"
  value       = azurerm_subnet.bastion.id
}

output "group_a_nsg_id" {
  description = "NSG ID group A subnet"
  value       = azurerm_network_security_group.group_a.id
}

output "group_b_nsg_id" {
  description = "NSG ID Group B subnet"
  value       = azurerm_network_security_group.group_b.id
}