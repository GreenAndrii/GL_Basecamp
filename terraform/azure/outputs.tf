output "nginx_lb_entrypoint" {
  description = "DNS for loadbalancer entrypoint"
  value       = azurerm_public_ip.nginx_lb_ip.fqdn
}
