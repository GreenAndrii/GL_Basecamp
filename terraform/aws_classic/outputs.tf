output "nginx_entrypoint" {
  description = "DNS name for loadbalancer entrypoint"
  value       = aws_elb.nginx_elb.dns_name
}