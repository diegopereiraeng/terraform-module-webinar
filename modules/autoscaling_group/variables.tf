variable "desired_capacity" {
  description = "Desired capacity of the autoscaling group"
  type        = number
  default     = 1
}

variable "max_size" {
  description = "Maximum size of the autoscaling group"
  type        = number
  default     = 1
}

variable "min_size" {
  description = "Minimum size of the autoscaling group"
  type        = number
  default     = 1
}

variable "subnet_ids" {
  description = "List of subnet IDs"
  type        = list(string)
}

variable "launch_template_id" {
  description = "Launch Template ID"
  type        = string
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
}