module "redis" {
  source       = "github.com/SailerAI/terraform-elasticache"
  project_name = "sailer"
  environment  = "dev"
  region       = "us-east-1"

  ### SSM VPC Parameters created by networkin module
  ssm_vpc_id              = "/sailer/dev/vpc/id"
  ssm_database_subnet_ids = ["/sailer/dev/database-subnet-1a", "/sailer/dev/database-subnet-1b", "/sailer/dev/database-subnet-1c"]

}