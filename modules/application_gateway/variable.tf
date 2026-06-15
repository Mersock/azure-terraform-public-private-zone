variable "name_prefix" {
  description = "Name Application Gateway"
  type        = string
}

variable "resource_group_name" {
  description = "Resource group name"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "app_gateway_subnet_id" {
  description = "Subnet ID Application Gateway subnet."
  type        = string
}

variable "group_b_private_ip_addresses" {
  description = "Private IP Group B VMs."
  type        = list(string)
}

variable "ssl_certificate_password" {
  description = "Password generated self-signed certificate"
  type        = string
  sensitive   = true
}

variable "self_signed_cert_common_name" {
  description = "Common name generated self-signed certificate"
  type        = string
  default     = "test-appgw.local"
}

variable "self_signed_cert_days" {
  description = "Period for the generated self-signed certificate"
  type        = number
  default     = 365
}

variable "backend_port" {
  description = "Backend port Group B VMs."
  type        = number
  default     = 443
}

variable "backend_protocol" {
  description = "Backend protocol Group B VMs."
  type        = string
  default     = "Https"

  validation {
    condition     = contains(["Http", "Https"], var.backend_protocol)
    error_message = "backend_protocol must be Http or Https."
  }
}

variable "public_ip_domain_name_label" {
  description = "DNS label Application Gateway public IP."
  type        = string
  default     = null
}

variable "capacity" {
  description = "Application Gateway instance capacity"
  type        = number
  default     = 1
}

variable "tags" {
  description = "Tags"
  type        = map(string)
  default     = {}
}