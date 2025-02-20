resource "aws_ecs_cluster" "cluster" {
  name = var.cluster_name
  tags = var.tags
}

locals {
  generated_manifest = templatefile("${path.module}/templates/banking-ecs-service-v2.yaml", {
    service_name                       = var.service_name
    cluster_arn                        = aws_ecs_cluster.cluster.arn
    target_group_arn                   = var.target_group_arn
    container_name                     = var.container_name
    container_port                     = var.container_port
    desired_count                      = var.desired_count
    deployment_maximum_percent         = 200
    deployment_minimum_healthy_percent = 50
  })
}

resource "local_file" "generated_manifest_file" {
  content  = local.generated_manifest
  filename = "${path.module}/generated/banking-ecs-service-v2.yaml"
}

resource "harness_platform_file_store_folder" "ecs_folder" {
  org_id            = var.harness_organization_id
  project_id        = var.harness_project_id
  identifier        = "ecs_service_definitions"
  name              = "ecs_service_definitions"
  description       = "ECS Folder"
  tags              = ["provisioned:by-automation"]
  parent_identifier = "Root"
}

resource "harness_platform_file_store_folder" "ecs_service_folder" {
  org_id            = var.harness_organization_id
  project_id        = var.harness_project_id
  identifier        = format("%s_%s", harness_platform_file_store_folder.ecs_folder.id, lower(format("%s", replace(var.service_name, "-", "_"))))
  name              = lower(format("%s", replace(var.service_name, "-", "_")))
  description       = "ECS service Folder"
  tags              = ["provisioned:by-automation"]
  parent_identifier = harness_platform_file_store_folder.ecs_folder.id
}

resource "harness_platform_file_store_folder" "env_folder" {
  org_id            = var.harness_organization_id
  project_id        = var.harness_project_id
  identifier        = format("%s_%s_%s", 
                           harness_platform_file_store_folder.ecs_folder.id, 
                           lower(format("%s", replace(var.service_name, "-", "_"))), 
                           lower(format("%s", replace(var.env_name, "-", "_")))
                          )
  name              = var.env_name
  description       = "ECS Env Folder for ${var.env_name}"
  tags              = ["provisioned:by-automation"]
  parent_identifier = harness_platform_file_store_folder.ecs_service_folder.id
}


resource "harness_platform_file_store_file" "ecs_service_manifest" {
  org_id            = var.harness_organization_id
  project_id        = var.harness_project_id
  identifier        = format("%s_%s_%s_%s", 
                           harness_platform_file_store_folder.ecs_folder.id, 
                           lower(format("%s", replace(var.service_name, "-", "_"))),
                           lower(format("%s", replace(var.env_name, "-", "_"))), 
                           lower(format("%s", replace(var.service_name, "-", "_")))
                          )
  name              = format("%s-%s", var.service_name, ".yaml")
  description       = "ECS Service Definition YAML for ${var.service_name}"
  tags              = ["provisioned:by-automation"]
  parent_identifier = harness_platform_file_store_folder.env_folder.id
  
  file_content_path = local_file.generated_manifest_file.filename
  mime_type         = "text/yaml"
  file_usage        = "MANIFEST_FILE"
  
  depends_on = [local_file.generated_manifest_file]
}

