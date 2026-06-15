resource "azurerm_public_ip" "bastion" {
  name                = var.bastion_public_ip_name
  resource_group_name = var.resource_group_name
  location            = var.location

  allocation_method = "Static"
  sku               = "Standard"
}

resource "azurerm_bastion_host" "bastion" {
  name                = var.bastion_name
  resource_group_name = var.resource_group_name
  location            = var.location

  sku               = "Standard"
  tunneling_enabled = true

  ip_configuration {
    name                 = "bastion-ipconfig"
    subnet_id            = var.bastion_subnet_id
    public_ip_address_id = azurerm_public_ip.bastion.id
  }
}