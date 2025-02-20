
data "aws_ssm_parameter" "vpc_id" {
  name = var.ssm_vpc_id
}

data "aws_ssm_parameter" "database_subnet_ids" {
  count = length(var.ssm_database_subnet_ids)
  name  = element(var.ssm_database_subnet_ids, count.index)
}
