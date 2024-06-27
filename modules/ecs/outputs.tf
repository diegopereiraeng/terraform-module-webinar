output "ecs_cluster_id" {
  description = "O ID do cluster ECS"
  value       = aws_ecs_cluster.cluster.id
}

output "ecs_service_name" {
  description = "O nome do serviço ECS"
  value       = aws_ecs_service.service.name
}
