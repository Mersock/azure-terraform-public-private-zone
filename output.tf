output "bastion_host_id" {
  description = "ID Azure Bastion host"
  value       = module.bastion.bastion_host_id
}

output "bastion_host_name" {
  description = "Name Azure Bastion host"
  value       = module.bastion.bastion_host_name
}

output "bastion_public_ip_address" {
  description = "Public IP address Azure Bastion"
  value       = module.bastion.bastion_public_ip_address
}