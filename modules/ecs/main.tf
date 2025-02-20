resource "aws_ecs_cluster" "cluster" {
  name = var.cluster_name
  tags = var.tags
}

resource "aws_ecs_service" "service" {
  name            = var.service_name
  cluster         = aws_ecs_cluster.cluster.id
  task_definition = var.task_definition
  desired_count   = var.desired_count
  launch_type     = "FARGATE"
  tags            = var.tags

  deployment_minimum_healthy_percent = 50
  deployment_maximum_percent         = 200

  load_balancer {
    target_group_arn = var.target_group_arn
    container_name   = var.container_name
    container_port   = var.container_port
  }
}
