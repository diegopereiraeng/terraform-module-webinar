output "launch_template_id" {
  description = "Launch Template ID"
  value       = aws_launch_template.ecs_lt.id
}

# output "public_dns" {
#   description = "Public DNS of the instances launched by this template"
#   value       = aws_instance.your_instance_name.public_dns
# }