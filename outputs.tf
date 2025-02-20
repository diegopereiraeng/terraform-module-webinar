output "vpc_id" {
  description = "VPC ID"
  value       = module.vpc.vpc_id
}

output "subnet_ids" {
  description = "Subnet IDs"
  value       = [for s in module.subnet : s.id]
}

output "security_group_id" {
  description = "Security Group ID"
  value       = module.security_group.security_group_id
}

output "ecs_cluster_id" {
  description = "ECS Cluster ID"
  value       = module.ecs.ecs_cluster_id
}

output "ecs_service_name" {
  description = "ECS Service Name"
  value       = module.ecs.ecs_service_name
}

output "launch_template_id" {
  description = "Launch Template ID"
  value       = module.launch_template.launch_template_id
}

output "autoscaling_group_id" {
  description = "Autoscaling Group ID"
  value       = module.autoscaling_group.autoscaling_group_id
}

output "load_balancer_arn" {
  description = "Load Balancer ARN"
  value       = module.load_balancer.load_balancer_arn
}

output "target_group_arn" {
  description = "Target Group ARN"
  value       = module.target_group.target_group_arn
}

output "listener_arn" {
  description = "Listener ARN"
  value       = module.listener.listener_arn
}

output "key_name" {
  description = "Key Pair Name"
  value       = module.key_pair.key_name
}

output "ecs_task_definition_arn" {
  description = "The ECS Task Definition ARN from the module"
  value       = module.ecs_task_definition.task_definition_arn
}


output "ecs_service_arn" {
  description = "The ARN of the ECS service"
  value       = module.ecs.ecs_service_arn
}

output "ecs_container_name" {
  description = "The container name as specified in the ECS service load_balancer block"
  value       = module.ecs.ecs_container_name
}

output "ecs_container_port" {
  description = "The container port as specified in the ECS service load_balancer block"
  value       = module.ecs.ecs_container_port
}

output "ecs_desired_count" {
  description = "The desired number of task instances for the ECS service"
  value       = module.ecs.ecs_desired_count
}

output "ecs_tags" {
  description = "The tags applied to the ECS service"
  value       = module.ecs.ecs_tags
}