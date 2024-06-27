variable "vpc_id" {
  description = "O ID da VPC"
  type        = string
}

variable "cidr_block" {
  description = "O bloco CIDR para a subnet"
  type        = string
}

variable "map_public_ip_on_launch" {
  description = "Mapear IP público no lançamento"
  type        = bool
  default     = true
}

variable "availability_zone" {
  description = "Zona de disponibilidade para a subnet"
  type        = string
}

variable "tags" {
  description = "Tags a serem aplicadas aos recursos"
  type        = map(string)
}
