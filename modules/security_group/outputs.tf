output "security_group_id" {
  description = "O ID do grupo de segurança"
  value       = aws_security_group.ecs_security_group.id
}
