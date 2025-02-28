variable "region" {
    type        = string
    description = "AWS Region where resources will be created"
}

variable "project_name" {
    type        = string
    description = "Name of the project"
}

variable "environment" {
    type        = string
    description = "Environment (e.g., dev, staging, prod)"
}

variable "ssm_vpc_id" {
    description = "ID do VPC"
    type        = string
}

variable "ssm_database_subnet_ids" {
    description = "IDs das subredes de banco de dados"
    type        = list(string)
}

variable "engine" {
    type        = string
    description = "Redis engine type"
    default = "redis"
}

variable "node_type" {
    type        = string
    description = "The compute and memory capacity of the nodes"
    default = "cache.t4g.micro"
}

variable "num_node_groups" {
    type        = number
    description = "Number of node groups (shards) for the Redis cluster"
    default = 1
}

variable "parameter_group_name" {
    type        = string
    description = "Name of the parameter group to associate with this Redis cluster"
    default = "default.redis7"
}


variable "engine_version" {
    type        = string
    description = "Version number of the Redis engine"
    default = "7.1"
}

variable "port" {
    type        = number
    default     = 6379
    description = "Port number for Redis cluster"
}


#variable "azs" {
#    type        = list(string)
#    description = "List of Availability Zones"
#}

variable "replicas_per_node_group" {
    type        = number
    description = "Number of replica nodes in each node group"
    default = 1
}
