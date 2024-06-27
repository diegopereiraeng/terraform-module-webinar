variable "cidr_block" {
  description = "O bloco CIDR para a VPC"
  type        = string
}

variable "enable_dns_hostnames" {
  description = "Habilitar nomes DNS na VPC"
  type        = bool
  default     = true
}

variable "tags" {
  description = "Tags a serem aplicadas aos recursos"
  type        = map(string)
}
