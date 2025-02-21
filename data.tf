# Retrieve the VPC ID from AWS Systems Manager Parameter Store
# This allows for dynamic VPC reference without hardcoding the ID
data "aws_ssm_parameter" "vpc_id" {
  name = var.ssm_vpc_id
}

# Fetch database subnet IDs from SSM Parameter Store
# Creates multiple data sources based on the number of subnet parameters provided
# Useful for configuring resources that need to be placed in multiple subnets
data "aws_ssm_parameter" "database_subnet_ids" {
  count = length(var.ssm_database_subnet_ids)
  name  = element(var.ssm_database_subnet_ids, count.index)
}
