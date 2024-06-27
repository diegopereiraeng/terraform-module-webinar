output "load_balancer_arn" {
  description = "Load Balancer ARN"
  value       = aws_lb.main.arn
}
output "dns_name" {
  description = "DNS name of the load balancer"
  value       = aws_lb.main.dns_name
}