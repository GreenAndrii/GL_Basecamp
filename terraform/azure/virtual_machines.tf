resource "azurerm_linux_virtual_machine" "nginx-web-server-1" {
  name                = "nginx-web-server-1"
  resource_group_name = azurerm_resource_group.nginx_rg.name
  location            = azurerm_resource_group.nginx_rg.location
  size                = "Standard_F2"
  admin_username      = var.admin_username
  custom_data         = base64encode(file("./script/install_nginx.sh"))
  zone                = 1
  network_interface_ids = [
    azurerm_network_interface.nginx_net_int_1.id,
  ]

  admin_ssh_key {
    username   = var.admin_username
    public_key = file("~/.ssh/id_rsa.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
}

resource "azurerm_linux_virtual_machine" "nginx-web-server-2" {
  name                = "nginx-web-server-2"
  resource_group_name = azurerm_resource_group.nginx_rg.name
  location            = azurerm_resource_group.nginx_rg.location
  size                = "Standard_F2"
  admin_username      = var.admin_username
  custom_data         = base64encode(file("./script/install_nginx.sh"))
  zone                = 2
  network_interface_ids = [
    azurerm_network_interface.nginx_net_int_2.id,
  ]

  admin_ssh_key {
    username   = var.admin_username
    public_key = file("~/.ssh/id_rsa.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
}
