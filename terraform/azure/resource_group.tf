resource "azurerm_resource_group" "nginx_rg" {
  name     = "nginx_resource_group"
  location = var.location

  tags = {
    Name        = "Nginx webserver resource group"
    Terraform   = "true"
    Environment = "dev"
  }
}
