output "load_balancer_arn" {
  description = "Load Balancer ARN"
  value       = aws_lb.main.arn
}
output "dns_name" {
  description = "DNS name of the load balancer"
  value       = aws_lb.your_load_balancer_name.dns_name
}