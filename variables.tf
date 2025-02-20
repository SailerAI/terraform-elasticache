variable "region" {
    type = string
}

variable "project_name" {
    type = string
}

variable "environment" {
    type = string
}

variable "engine" {
  type = string
}

variable "node_type" {
  type = string
}

variable "num_node_groups" {
  type = string
}

variable "parameter_group_name" {
 type = string 
}

variable "engine_version" {
  type = string
}

variable "port" {
  type = number
  default = 6379
}

variable "ssm_vpc_id" {
  description = "ID do VPC"
  type        = string
}
variable "ssm_database_subnet_ids" {
  description = "IDs das subredes de banco de dados"
  type        = list(string)
}
 variable "azs" {
   type = list(string)
 }
variable "replicas_per_node_group" {
  
}
