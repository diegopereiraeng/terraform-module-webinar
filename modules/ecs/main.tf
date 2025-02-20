resource "aws_ecs_cluster" "cluster" {
  name = var.cluster_name
  tags = var.tags
}

resource "aws_ecs_service" "service" {
  name            = var.service_name
  cluster         = aws_ecs_cluster.cluster.id
  task_definition = var.task_definition
  desired_count   = var.desired_count
  launch_type     = "EC2"
  tags            = var.tags

  deployment_minimum_healthy_percent = 50
  deployment_maximum_percent         = 200

  load_balancer {
    target_group_arn = var.target_group_arn
    container_name   = var.container_name
    container_port   = var.container_port
  }
}

resource "harness_platform_file_store_file" "ecs_service_manifest" {
  org_id            = var.harness_organization_id
  project_id        = var.harness_project_id
  identifier        = var.service_name
  name              = var.service_name
  description       = "ECS Service Definition YAML for ${var.service_name}"
  tags              = ["provisioned:by-automation"]
  parent_identifier = "Root"

  file_content = templatefile("${path.module}/templates/banking-ecs-service-v2.yaml", {
    ecs_service_arn                    = service.service.arn
    service_name                       = var.service_name
    cluster_arn                        = cluster.cluster.arn
    target_group_arn                   = var.target_group_arn
    container_name                     = var.container_name
    container_port                     = var.container_port
    desired_count                      = var.desired_count
    task_definition                    = var.task_definition
    deployment_maximum_percent         = 200
    deployment_minimum_healthy_percent = 50
  })

  mime_type  = "text/yaml"
  file_usage = "ManifestFile"
}

