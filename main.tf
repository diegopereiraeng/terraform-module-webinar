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
  task_definition = var.task_definition
  desired_count   = 2
  target_group_arn = var.target_group_arn
  container_name  = "web"
  container_port  = 80
  tags            = var.tags
}
