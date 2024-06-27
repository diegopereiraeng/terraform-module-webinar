resource "aws_lb_target_group" "main" {
  name        = "main-target-group"
  port        = 80
  protocol    = "TCP"
  vpc_id      = var.vpc_id
  target_type = "instance"

  health_check {
    port     = "traffic-port"
    protocol = "TCP"
  }

  tags = var.tags
}
