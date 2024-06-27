terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region     = "us-east-1"
  access_key = var.access_key
  secret_key = var.secret_key
}

module "vpc" {
  source = "./modules/vpc"
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  tags                 = var.tags
}

module "subnet" {
  source = "./modules/subnet"

  for_each = {
    subnet1 = {
      cidr_block        = "10.0.1.0/24"
      availability_zone = "us-east-1a"
    }
    subnet2 = {
      cidr_block        = "10.0.2.0/24"
      availability_zone = "us-east-1b"
    }
  }

  vpc_id               = module.vpc.vpc_id
  map_public_ip_on_launch = true
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

  for_each = {
    subnet1 = module.subnet["subnet1"].subnet_id
    subnet2 = module.subnet["subnet2"].subnet_id
  }

  subnet_id      = each.value
  route_table_id = module.route_table.route_table_id
}

module "security_group" {
  source = "./modules/security_group"
  name   = "ecs_security_group"
  vpc_id = module.vpc.vpc_id
  ingress_rules = var.security_group_ingress_rules
  tags   = var.tags
}

module "ecs" {
  source          = "./modules/ecs"
  cluster_name    = "ecs-cluster"
  service_name    = "web-service"
  task_definition = var.task_definition
  desired_count   = 2
  target_group_arn = var.target_group_arn
  container_name  = "web"
  container_port  = 80
  tags            = var.tags
}

module "iam_roles" {
  source = "./modules/iam_roles"
  tags   = var.tags
}

module "ecs_task_definition" {
  source = "./modules/ecs_task_definition"
  execution_role_arn = module.iam_roles.ecs_task_execution_role_arn
  task_role_arn      = module.iam_roles.ecs_task_role_arn
  container_name     = "projeto-x"
  container_image    = "paulothelibertines/projeto-x:latest"
  container_port     = 80
  tags               = var.tags
}

module "launch_template" {
  source = "./modules/launch_template"
  security_group_id     = module.security_group.security_group_id
  instance_profile_name = module.iam_roles.instance_profile_name
  key_name              = module.key_pair.key_name
  tags                  = var.tags
}

module "autoscaling_group" {
  source = "./modules/autoscaling_group"
  launch_template_id = module.launch_template.launch_template_id
  subnet_ids         = module.subnet[*].subnet_id
  tags               = var.tags
}

module "load_balancer" {
  source = "./modules/load_balancer"
  subnet_ids = module.subnet[*].subnet_id
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
  key_name = "deployer-key"
  public_key_path = var.public_key_path
}
