variable "region" {
  description = "A região AWS para implantação"
  type        = string
  default     = "us-east-1"
}

variable "vpc_cidr" {
  description = "O bloco CIDR para a VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "tags" {
  description = "Tags a serem aplicadas aos recursos"
  type        = map(string)
  default     = {
    Environment = "Dev"
    Project     = "Webinar"
  }
}
