variable "name" {
  description = "O nome do grupo de segurança"
  type        = string
}

variable "vpc_id" {
  description = "O ID da VPC"
  type        = string
}

variable "tags" {
  description = "Tags a serem aplicadas aos recursos"
  type        = map(string)
}
