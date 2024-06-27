resource "aws_lb" "main" {
  name               = "main-nlb"
  internal           = false
  load_balancer_type = "network"
  subnets            = var.subnet_ids
  security_groups    = [var.security_group_id]
  enable_deletion_protection = false

  lifecycle {
    create_before_destroy = true
  }

  tags = var.tags
}