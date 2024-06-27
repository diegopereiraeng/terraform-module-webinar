resource "aws_launch_template" "ecs_lt" {
  name_prefix   = "ecs-template"
  image_id      = "ami-057f57c2fcd14e5f4"  # ECS-optimized AMI
  instance_type = "t3.micro"
  key_name      = var.key_name

  vpc_security_group_ids = [var.security_group_id]
  iam_instance_profile {
    name = var.instance_profile_name
  }

  block_device_mappings {
    device_name = "/dev/xvda"
    ebs {
      volume_size = 30
      volume_type = "gp2"
    }
  }

  tag_specifications {
    resource_type = "instance"
    tags = var.tags
  }
  user_data = filebase64("${path.module}/setup.sh")
}
