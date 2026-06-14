resource "azurerm_network_security_group" "group_a" {
  name                = "nsg-${var.project_name}-group-a"
  location            = var.location
  resource_group_name = var.resource_group_name

  security_rule {
    name                       = "Allow-GroupB-To-GroupA-9042"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "9042"
    source_address_prefix      = var.group_b_subnet_address_prefix
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "Allow-Bastion-To-GroupA-SSH"
    priority                   = 110
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = var.bastion_subnet_address_prefix
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "Deny-VNet-To-GroupA"
    priority                   = 400
    direction                  = "Inbound"
    access                     = "Deny"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "VirtualNetwork"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "Deny-GroupA-To-VNet"
    priority                   = 400
    direction                  = "Outbound"
    access                     = "Deny"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "VirtualNetwork"
  }

  tags = var.tags
}

resource "azurerm_network_security_group" "group_b" {
  name                = "nsg-${var.project_name}-group-b"
  location            = var.location
  resource_group_name = var.resource_group_name

  security_rule {
    name                       = "Allow-AppGateway-To-GroupB-443"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = var.app_gateway_subnet_address_prefix
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "Allow-Bastion-To-GroupB-SSH"
    priority                   = 110
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = var.bastion_subnet_address_prefix
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "Deny-VNet-To-GroupB"
    priority                   = 400
    direction                  = "Inbound"
    access                     = "Deny"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "VirtualNetwork"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "Allow-GroupB-To-GroupA-9042"
    priority                   = 100
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "9042"
    source_address_prefix      = "*"
    destination_address_prefix = var.group_a_subnet_address_prefix
  }

  security_rule {
    name                       = "Deny-GroupB-To-VNet"
    priority                   = 400
    direction                  = "Outbound"
    access                     = "Deny"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "VirtualNetwork"
  }

  tags = var.tags
}

resource "azurerm_subnet_network_security_group_association" "group_a" {
  subnet_id                 = var.group_a_subnet_id
  network_security_group_id = azurerm_network_security_group.group_a.id
}

resource "azurerm_subnet_network_security_group_association" "group_b" {
  subnet_id                 = var.group_b_subnet_id
  network_security_group_id = azurerm_network_security_group.group_b.id
}