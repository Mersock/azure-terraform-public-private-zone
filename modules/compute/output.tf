output "group_a_vm_ids" {
  description = "IDs Group A VMs"
  value       = azurerm_linux_virtual_machine.group_a[*].id
}

output "group_a_vm_names" {
  description = "NamesGroup A VMs"
  value       = azurerm_linux_virtual_machine.group_a[*].name
}

output "group_a_private_ip_addresses" {
  description = "Private IP Group A VMs"
  value       = azurerm_network_interface.group_a[*].private_ip_address
}

output "group_a_network_interface_ids" {
  description = "NIC IDs Group A VMs"
  value       = azurerm_network_interface.group_a[*].id
}

output "group_b_vm_ids" {
  description = "IDs Group B VMs"
  value       = azurerm_linux_virtual_machine.group_b[*].id
}

output "group_b_vm_names" {
  description = "Names Group B VMs"
  value       = azurerm_linux_virtual_machine.group_b[*].name
}

output "group_b_private_ip_addresses" {
  description = "Private IP Group B VMs"
  value       = azurerm_network_interface.group_b[*].private_ip_address
}

output "group_b_network_interface_ids" {
  description = "NIC IDs Group B VMs"
  value       = azurerm_network_interface.group_b[*].id
}