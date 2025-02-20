output "ecs_cluster_id" {
  description = "O ID do cluster ECS"
  value       = aws_ecs_cluster.cluster.id
}

output "ecs_service_name" {
  description = "O nome do serviço ECS"
  value       = aws_ecs_service.service.name
}

output "ecs_service_arn" {
  description = "The ARN of the ECS service"
  value       = aws_ecs_service.service.id
}

output "ecs_container_name" {
  description = "The container name as specified in the ECS service load_balancer block"
  value       = var.container_name
}

output "ecs_container_port" {
  description = "The container port as specified in the ECS service load_balancer block"
  value       = var.container_port
}

output "ecs_desired_count" {
  description = "The desired number of task instances for the ECS service"
  value       = var.desired_count
}

output "ecs_tags" {
  description = "The tags applied to the ECS service"
  value       = var.tags
}