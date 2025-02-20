terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    harness = {
      source = "harness/harness"
      version = "0.35.5"
    }
  }
  backend "s3" {}
}

provider "harness" {
  account_id       = var.account_id
  platform_api_key = var.platform_api_key
}

provider "aws" {
  region     = var.region
  # access_key = var.access_key
  # secret_key = var.secret_key
}

module "vpc" {
  source = "./modules/vpc"
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = var.enable_dns_hostnames
  tags                 = var.tags
}

module "subnet" {
  source = "./modules/subnet"

  for_each = var.subnets

  vpc_id               = module.vpc.vpc_id
  cidr_block           = each.value.cidr_block
  availability_zone    = each.value.availability_zone
  map_public_ip_on_launch = var.map_public_ip_on_launch
  tags                 = var.tags
}

module "internet_gateway" {
  source = "./modules/internet_gateway"
  vpc_id = module.vpc.vpc_id
  tags   = var.tags
}

module "route_table" {
  source = "./modules/route_table"
  vpc_id = module.vpc.vpc_id
  igw_id = module.internet_gateway.igw_id
  tags   = var.tags
}

module "route_table_association" {
  source = "./modules/route_table_association"

  for_each = module.subnet
  subnet_id      = each.value.id
  route_table_id = module.route_table.route_table_id
}


module "security_group" {
  source = "./modules/security_group"
  name   = var.security_group_name
  vpc_id = module.vpc.vpc_id
  ingress_rules = var.security_group_ingress_rules
  tags   = var.tags
}

module "ecs" {
  source          = "./modules/ecs"
  cluster_name    = var.ecs_cluster_name
  service_name    = var.ecs_service_name
  task_definition = module.ecs_task_definition.task_definition_arn
  desired_count   = var.ecs_desired_count
  target_group_arn = module.target_group.target_group_arn
  container_name  = var.ecs_container_name
  container_port  = var.ecs_container_port
  tags            = var.tags
  harness_organization_id   = var.harness_organization_id
  harness_project_id        = var.harness_project_id
  account_id        = var.account_id
  platform_api_key  = var.platform_api_key
}

module "iam_roles" {
  source = "./modules/iam_roles"
  tags   = var.tags
}

module "ecs_task_definition" {
  source = "./modules/ecs_task_definition"
  execution_role_arn = module.iam_roles.ecs_task_execution_role_arn
  task_role_arn      = module.iam_roles.ecs_task_role_arn
  container_name     = var.ecs_container_name
  container_image    = var.ecs_container_image
  container_port     = var.ecs_container_port
  tags               = var.tags
}

module "launch_template" {
  source = "./modules/launch_template"
  security_group_id     = module.security_group.security_group_id
  instance_profile_name = module.iam_roles.ecs_instance_profile_name
  key_name              = var.key_name
  ami                   = var.ami
  vm_size               = var.vm_size
  tags                  = var.tags
}

module "autoscaling_group" {
  source = "./modules/autoscaling_group"
  desired_capacity   = var.ecs_desired_count
  max_size           = var.ecs_max_size
  min_size           = var.ecs_min_size
  subnet_ids         = [for s in module.subnet : s.id]
  launch_template_id = module.launch_template.launch_template_id
  tags               = var.tags
}

module "load_balancer" {
  source = "./modules/load_balancer"
  subnet_ids = [for s in module.subnet : s.id]
  security_group_id = module.security_group.security_group_id
  tags              = var.tags
}

module "target_group" {
  source = "./modules/target_group"
  vpc_id = module.vpc.vpc_id
  tags   = var.tags
}

module "listener" {
  source             = "./modules/listener"
  load_balancer_arn  = module.load_balancer.load_balancer_arn
  target_group_arn   = module.target_group.target_group_arn
  tags               = var.tags
}

module "key_pair" {
  source = "./modules/key_pair"
  key_name = var.key_name
  public_key = var.public_key
}
