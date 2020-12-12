output "nginx_entrypoint" {
  description = "DNS name for loadbalancer entrypoint"
  value       = aws_lb.nginx_network_lb.dns_name
}
