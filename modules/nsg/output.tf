output "group_a_nsg_id" {
  value = azurerm_network_security_group.group_a.id
}

output "group_b_nsg_id" {
  value = azurerm_network_security_group.group_b.id
}

output "group_a_nsg_name" {
  value = azurerm_network_security_group.group_a.name
}

output "group_b_nsg_name" {
  value = azurerm_network_security_group.group_b.name
}