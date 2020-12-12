resource "azurerm_network_security_group" "nginx-nsg" {
  name                = "nginx_network_security_group"
  resource_group_name = azurerm_resource_group.nginx_rg.name
  location            = azurerm_resource_group.nginx_rg.location

  security_rule {
    name                       = "Http"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  tags = {
    Name        = "Nginx network SG"
    Terraform   = "true"
    Environment = "dev"
  }
}

resource "azurerm_subnet_network_security_group_association" "nginx_subnet_SG_assoc_1" {
  subnet_id                 = azurerm_subnet.nginx_subnet_1.id
  network_security_group_id = azurerm_network_security_group.nginx-nsg.id
}

resource "azurerm_subnet_network_security_group_association" "nginx_subnet_SG_assoc_2" {
  subnet_id                 = azurerm_subnet.nginx_subnet_2.id
  network_security_group_id = azurerm_network_security_group.nginx-nsg.id
}
