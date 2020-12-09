resource "azurerm_virtual_network" "nginx_virt_net" {
  name                = "nginx_virtual_network"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.nginx_rg.location
  resource_group_name = azurerm_resource_group.nginx_rg.name

  tags = {
    Name        = "Nginx virtual network"
    Terraform   = "true"
    Environment = "dev"
  }
}

resource "azurerm_subnet" "nginx_subnet_1" {
  name                 = "nginx_subnet_1"
  resource_group_name  = azurerm_resource_group.nginx_rg.name
  virtual_network_name = azurerm_virtual_network.nginx_virt_net.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_subnet" "nginx_subnet_2" {
  name                 = "nginx_subnet_2"
  resource_group_name  = azurerm_resource_group.nginx_rg.name
  virtual_network_name = azurerm_virtual_network.nginx_virt_net.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_network_interface" "nginx_net_int_1" {
  name                = "nginx_network_interface_1"
  location            = azurerm_resource_group.nginx_rg.location
  resource_group_name = azurerm_resource_group.nginx_rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.nginx_subnet_1.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_network_interface" "nginx_net_int_2" {
  name                = "nginx_network_interface_2"
  location            = azurerm_resource_group.nginx_rg.location
  resource_group_name = azurerm_resource_group.nginx_rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.nginx_subnet_2.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_public_ip" "nginx_lb_ip" {
  name                = "nginx_public_IP_for_LB"
  location            = azurerm_resource_group.nginx_rg.location
  resource_group_name = azurerm_resource_group.nginx_rg.name
  allocation_method   = "Static"
  sku                 = "Standard"
  domain_name_label   = "gl-basecamp"
}
