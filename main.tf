module "vpc" {
  source = "./modules/vpc"

  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  tags                 = var.tags
}

module "subnet1" {
  source               = "./modules/subnet"
  vpc_id               = module.vpc.vpc_id
  cidr_block           = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone    = "us-east-1a"
  tags                 = var.tags
}

module "subnet2" {
  source               = "./modules/subnet"
  vpc_id               = module.vpc.vpc_id
  cidr_block           = "10.0.2.0/24"
  map_public_ip_on_launch = true
  availability_zone    = "us-east-1b"
  tags                 = var.tags
}

module "security_group" {
  source = "./modules/security_group"
  name   = "ecs_security_group"
  vpc_id = module.vpc.vpc_id
  tags   = var.tags
}

module "ecs" {
  source          = "./modules/ecs"

  cluster_name    = "ecs-cluster"
  service_name    = "web-service"
  task_definition = "arn:aws:ecs:us-east-1:123456789012:task-definition/web:1"
  desired_count   = 2
  target_group_arn = "arn:aws:elasticloadbalancing:us-east-1:123456789012:targetgroup/my-targets/6d0ecf831eec9f09"
  container_name  = "web"
  container_port  = 80
  tags            = var.tags
}
