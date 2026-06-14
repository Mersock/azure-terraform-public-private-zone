resource "azurerm_virtual_network" "this" {
  name                = "${var.name_prefix}-vnet"
  location            = var.location
  resource_group_name = var.resource_group_name

  address_space = var.vnet_address_space
}
############## subnet ##############
resource "azurerm_subnet" "group_a" {
  name                 = "group-a-subnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.this.name

  address_prefixes = [var.group_a_subnet_cidr]
}

resource "azurerm_subnet" "group_b" {
  name                 = "group-b-subnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.this.name

  address_prefixes = [var.group_b_subnet_cidr]
}

resource "azurerm_subnet" "app_gateway" {
  name                 = "app-gateway-subnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.this.name

  address_prefixes = [var.app_gateway_subnet_cidr]
}

resource "azurerm_subnet" "bastion" {
  name                 = "AzureBastionSubnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.this.name

  address_prefixes = [var.bastion_subnet_cidr]
}

############## security group a ##############
resource "azurerm_network_security_group" "group_a" {
  name                = "${var.name_prefix}-group-a-nsg"
  location            = var.location
  resource_group_name = var.resource_group_name

  security_rule {
    name                       = "Allow-Group-B-To-Group-A-9042"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "9042"
    source_address_prefix      = var.group_b_subnet_cidr
    destination_address_prefix = var.group_a_subnet_cidr
  }

  security_rule {
    name                       = "Allow-Bastion-To-Group-A-SSH"
    priority                   = 110
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = var.bastion_subnet_cidr
    destination_address_prefix = var.group_a_subnet_cidr
  }

  security_rule {
    name                       = "Deny-Other-VNet-To-Group-A"
    priority                   = 400
    direction                  = "Inbound"
    access                     = "Deny"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "VirtualNetwork"
    destination_address_prefix = var.group_a_subnet_cidr
  }
}

############## security group b ##############
resource "azurerm_network_security_group" "group_b" {
  name                = "${var.name_prefix}-group-b-nsg"
  location            = var.location
  resource_group_name = var.resource_group_name

  security_rule {
    name                       = "Allow-AppGateway-To-Group-B-443"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = var.app_gateway_subnet_cidr
    destination_address_prefix = var.group_b_subnet_cidr
  }

  security_rule {
    name                       = "Allow-Bastion-To-Group-B-SSH"
    priority                   = 110
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = var.bastion_subnet_cidr
    destination_address_prefix = var.group_b_subnet_cidr
  }

  security_rule {
    name                       = "Deny-Other-VNet-To-Group-B"
    priority                   = 400
    direction                  = "Inbound"
    access                     = "Deny"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "VirtualNetwork"
    destination_address_prefix = var.group_b_subnet_cidr
  }
}

resource "azurerm_subnet_network_security_group_association" "group_a" {
  subnet_id                 = azurerm_subnet.group_a.id
  network_security_group_id = azurerm_network_security_group.group_a.id
}

resource "azurerm_subnet_network_security_group_association" "group_b" {
  subnet_id                 = azurerm_subnet.group_b.id
  network_security_group_id = azurerm_network_security_group.group_b.id
}