

variable "harness_organization_id" {
  description = "Harness org identifier"
  type        = string
}

variable "harness_project_id" {
  description = "Harness project identifier"
  type        = string
}

variable "cluster_name" {
  description = "O nome do cluster ECS"
  type        = string
}

variable "service_name" {
  description = "O nome do serviço ECS"
  type        = string
}

variable "task_definition" {
  description = "O ARN da definição de tarefa a ser usada para o serviço"
  type        = string
}

variable "desired_count" {
  description = "O número de instâncias da definição de tarefa a serem executadas"
  type        = number
  default     = 1
}

variable "target_group_arn" {
  description = "O ARN do grupo de destino do balanceador de carga"
  type        = string
}

variable "container_name" {
  description = "O nome do contêiner a ser associado ao balanceador de carga"
  type        = string
}

variable "container_port" {
  description = "A porta no contêiner a ser associada ao balanceador de carga"
  type        = number
}

variable "tags" {
  description = "Tags a serem aplicadas aos recursos"
  type        = map(string)
}
