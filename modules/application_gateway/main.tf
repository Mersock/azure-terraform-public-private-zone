locals {
  application_gateway_name = "${var.name_prefix}-appgw"
  public_ip_name           = "${var.name_prefix}-appgw-pip"

  gateway_ip_configuration_name  = "appgw-ip-config"
  frontend_ip_configuration_name = "appgw-frontend-ip"
  frontend_port_name             = "https-port-443"

  ssl_certificate_name = "appgw-ssl-cert"

  backend_address_pool_name  = "group-b-backend-pool"
  backend_http_settings_name = "group-b-backend-settings"

  http_listener_name        = "https-listener"
  request_routing_rule_name = "https-to-group-b-rule"

  cert_dir      = "${path.root}/.generated-certs"
  cert_key_path = "${local.cert_dir}/${var.name_prefix}-appgw.key"
  cert_crt_path = "${local.cert_dir}/${var.name_prefix}-appgw.crt"
  cert_pfx_path = "${local.cert_dir}/${var.name_prefix}-appgw.pfx"
}

resource "terraform_data" "appgw_self_signed_cert" {
  triggers_replace = {
    common_name = var.self_signed_cert_common_name
    cert_days   = tostring(var.self_signed_cert_days)
    pfx_path    = local.cert_pfx_path
  }

  provisioner "local-exec" {
    interpreter = ["/bin/bash", "-c"]

    environment = {
      CERT_PASSWORD    = var.ssl_certificate_password
      CERT_COMMON_NAME = var.self_signed_cert_common_name
      CERT_DAYS        = tostring(var.self_signed_cert_days)
      CERT_DIR         = local.cert_dir
      CERT_KEY_PATH    = local.cert_key_path
      CERT_CRT_PATH    = local.cert_crt_path
      CERT_PFX_PATH    = local.cert_pfx_path
    }

    command = <<-EOT
      set -euo pipefail

      mkdir -p "$CERT_DIR"

      openssl req -x509 \
        -newkey rsa:2048 \
        -sha256 \
        -days "$CERT_DAYS" \
        -nodes \
        -keyout "$CERT_KEY_PATH" \
        -out "$CERT_CRT_PATH" \
        -subj "/CN=$CERT_COMMON_NAME" \
        -addext "subjectAltName=DNS:$CERT_COMMON_NAME"

      openssl pkcs12 -export \
        -out "$CERT_PFX_PATH" \
        -inkey "$CERT_KEY_PATH" \
        -in "$CERT_CRT_PATH" \
        -passout env:CERT_PASSWORD
    EOT
  }
}

data "local_sensitive_file" "appgw_pfx" {
  filename = local.cert_pfx_path

  depends_on = [
    terraform_data.appgw_self_signed_cert
  ]
}

resource "azurerm_public_ip" "this" {
  name                = local.public_ip_name
  resource_group_name = var.resource_group_name
  location            = var.location

  allocation_method = "Static"
  sku               = "Standard"

  domain_name_label = var.public_ip_domain_name_label

  tags = var.tags
}

resource "azurerm_application_gateway" "this" {
  name                = local.application_gateway_name
  resource_group_name = var.resource_group_name
  location            = var.location

  sku {
    name     = "Standard_v2"
    tier     = "Standard_v2"
    capacity = var.capacity
  }

  gateway_ip_configuration {
    name      = local.gateway_ip_configuration_name
    subnet_id = var.app_gateway_subnet_id
  }

  frontend_ip_configuration {
    name                 = local.frontend_ip_configuration_name
    public_ip_address_id = azurerm_public_ip.this.id
  }

  frontend_port {
    name = local.frontend_port_name
    port = 443
  }

  ssl_certificate {
    name     = local.ssl_certificate_name
    data     = data.local_sensitive_file.appgw_pfx.content_base64
    password = var.ssl_certificate_password
  }

  backend_address_pool {
    name         = local.backend_address_pool_name
    ip_addresses = var.group_b_private_ip_addresses
  }

  backend_http_settings {
    name                  = local.backend_http_settings_name
    cookie_based_affinity = "Disabled"

    port            = var.backend_port
    protocol        = var.backend_protocol
    request_timeout = 30
  }

  http_listener {
    name                           = local.http_listener_name
    frontend_ip_configuration_name = local.frontend_ip_configuration_name
    frontend_port_name             = local.frontend_port_name

    protocol             = "Https"
    ssl_certificate_name = local.ssl_certificate_name
  }

  request_routing_rule {
    name                       = local.request_routing_rule_name
    rule_type                  = "Basic"
    priority                   = 100
    http_listener_name         = local.http_listener_name
    backend_address_pool_name  = local.backend_address_pool_name
    backend_http_settings_name = local.backend_http_settings_name
  }

  tags = var.tags
}