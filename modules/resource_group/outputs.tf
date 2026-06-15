output "name" {
  description = "Resource group name"
  value       = azurerm_resource_group.this.name
}

output "location" {
  description = "Location"
  value       = azurerm_resource_group.this.location
}

output "id" {
  description = "ID Resource Group"
  value       = azurerm_resource_group.this.id
}