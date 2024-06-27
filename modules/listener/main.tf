resource "aws_lb_listener" "main" {
  load_balancer_arn = var.load_balancer_arn
  port              = 80
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = var.target_group_arn
  }

  tags = var.tags
}
