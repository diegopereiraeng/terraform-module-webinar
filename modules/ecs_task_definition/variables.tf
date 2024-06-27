variable "family" {
  description = "Task definition family"
  type        = string
  default     = "time-for-heroes"
}

variable "cpu" {
  description = "CPU for the task definition"
  type        = number
  default     = 256
}

variable "memory" {
  description = "Memory for the task definition"
  type        = number
  default     = 512
}

variable "execution_role_arn" {
  description = "ARN of the execution role"
  type        = string
}

variable "task_role_arn" {
  description = "ARN of the task role"
  type        = string
}

variable "container_name" {
  description = "Container name"
  type        = string
}

variable "container_image" {
  description = "Container image"
  type        = string
}

variable "container_port" {
  description = "Container port"
  type        = number
}

variable "container_cpu" {
  description = "CPU for the container"
  type        = number
  default     = 128
}

variable "container_memory" {
  description = "Memory for the container"
  type        = number
  default     = 256
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
}