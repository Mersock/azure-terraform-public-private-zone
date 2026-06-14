resource "azurerm_network_interface" "group_a" {
  count = 3

  name                = "${var.name_prefix}-group-a-nic-${count.index + 1}"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.group_a_subnet_id
    private_ip_address_allocation = "Dynamic"
  }

  tags = var.tags
}

resource "azurerm_network_interface" "group_b" {
  count = 3

  name                = "${var.name_prefix}-group-b-nic-${count.index + 1}"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.group_b_subnet_id
    private_ip_address_allocation = "Dynamic"
  }

  tags = var.tags
}

resource "azurerm_linux_virtual_machine" "group_a" {
  count = 3

  name                = "${var.name_prefix}-group-a-vm-${count.index + 1}"
  computer_name       = "group-a-vm-${count.index + 1}"
  location            = var.location
  resource_group_name = var.resource_group_name
  size                = var.group_a_vm_size
  admin_username      = var.admin_username

  disable_password_authentication = true

  network_interface_ids = [
    azurerm_network_interface.group_a[count.index].id
  ]

  dynamic "admin_ssh_key" {
    for_each = toset(var.admin_ssh_public_keys)

    content {
      username   = var.admin_username
      public_key = admin_ssh_key.value
    }
  }

  os_disk {
    name                 = "${var.name_prefix}-group-a-osdisk-${count.index + 1}"
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }

  tags = merge(var.tags, {
    workload = "memory-intensive"
    group    = "A"
  })
}

resource "azurerm_linux_virtual_machine" "group_b" {
  count = 3

  name                = "${var.name_prefix}-group-b-vm-${count.index + 1}"
  computer_name       = "group-b-vm-${count.index + 1}"
  location            = var.location
  resource_group_name = var.resource_group_name
  size                = var.group_b_vm_size
  admin_username      = var.admin_username

  disable_password_authentication = true

  network_interface_ids = [
    azurerm_network_interface.group_b[count.index].id
  ]

  dynamic "admin_ssh_key" {
    for_each = toset(var.admin_ssh_public_keys)

    content {
      username   = var.admin_username
      public_key = admin_ssh_key.value
    }
  }

  os_disk {
    name                 = "${var.name_prefix}-group-b-osdisk-${count.index + 1}"
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }

  tags = merge(var.tags, {
    workload = "cpu-intensive"
    group    = "B"
  })
}