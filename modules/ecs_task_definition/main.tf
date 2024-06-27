resource "aws_ecs_task_definition" "task_definition" {
  family                   = var.family
  network_mode             = "bridge"
  requires_compatibilities = ["EC2"]
  cpu                      = var.cpu
  memory                   = var.memory
  execution_role_arn       = var.execution_role_arn
  task_role_arn            = var.task_role_arn

  container_definitions = jsonencode([{
    name  = var.container_name
    image = var.container_image
    
    portMappings = [{
      containerPort = var.container_port
      hostPort      = var.container_port
      protocol      = "tcp"
    }]
    cpu       = var.container_cpu
    memory    = var.container_memory
    essential = true

    environment = [{
      name  = "PORT"
      value = tostring(var.container_port)
    }]
  }])
}
