variable "region" {
  description = "AWS region for deployment"
  type        = string
}

# variable "access_key" {
#   description = "AWS Access Key"
#   type        = string
# }

# variable "secret_key" {
#   description = "AWS Secret Key"
#   type        = string
# }

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "enable_dns_hostnames" {
  description = "Enable DNS hostnames for the VPC"
  type        = bool
}

variable "subnets" {
  description = "Subnets configuration"
  type = map(object({
    cidr_block        = string
    availability_zone = string
  }))
}

variable "map_public_ip_on_launch" {
  description = "Map public IP on launch"
  type        = bool
}

variable "security_group_name" {
  description = "Name of the security group"
  type        = string
}

variable "security_group_ingress_rules" {
  description = "List of ingress rules for the security group"
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
}

variable "ecs_cluster_name" {
  description = "ECS cluster name"
  type        = string
}

variable "ecs_service_name" {
  description = "ECS service name"
  type        = string
}

variable "ecs_desired_count" {
  description = "Desired count of ECS service"
  type        = number
}

variable "ecs_container_name" {
  description = "Container name"
  type        = string
}

variable "ecs_container_port" {
  description = "Container port"
  type        = number
}

variable "ecs_max_size" {
  description = "Autoscaling Max Size"
  type        = number
}

variable "ecs_min_size" {
  description = "Autoscaling Min Size"
  type        = number
}

variable "ecs_container_image" {
  description = "Container image"
  type        = string
}

variable "key_name" {
  description = "Name of the SSH key pair"
  type        = string
}

variable "public_key" {
  description = "SSH public key content"
  type        = string
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
}

