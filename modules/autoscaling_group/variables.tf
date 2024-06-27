variable "desired_capacity" {
  description = "Desired number of instances"
  type        = number
}

variable "max_size" {
  description = "Maximum number of instances"
  type        = number
}

variable "min_size" {
  description = "Minimum number of instances"
  type        = number
}

variable "subnet_ids" {
  description = "List of subnet IDs for the autoscaling group"
  type        = list(string)
}

variable "launch_template_id" {
  description = "Launch template ID"
  type        = string
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
}
