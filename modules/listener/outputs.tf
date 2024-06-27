output "listener_arn" {
  description = "Listener ARN"
  value       = aws_lb_listener.main.arn
}
