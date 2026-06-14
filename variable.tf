variable "subscription_id" {
  description = "Azure Subscription ID"
  type        = string
}

variable "tenant_id" {
  description = "Azure Tenant ID"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
  default     = "southeastasia"
}

variable "project_name" {
  description = "Project name"
  type        = string
  default     = "terraform-public-private-zone"
}

variable "resource_group_name" {
  description = "Resource group"
  type        = string
}
variable "tags" {
  description = "Tags resources"
  type        = map(string)
  default     = {}
}