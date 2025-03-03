# terraform-elasticache
Elasticacache terraform Module 

<!-- BEGIN_TF_DOCS -->


## Example

```hcl
module "redis" {
  source       = "github.com/SailerAI/terraform-elasticache"
  project_name = "sailer"
  environment  = "dev"
  region       = "us-east-1"

  ### SSM VPC Parameters created by networkin module
  ssm_vpc_id              = "/sailer/dev/vpc/id"
  ssm_database_subnet_ids = ["/sailer/dev/database-subnet-1a", "/sailer/dev/database-subnet-1b", "/sailer/dev/database-subnet-1c"]

}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_engine"></a> [engine](#input\_engine) | Redis engine type | `string` | `"redis"` | no |
| <a name="input_engine_version"></a> [engine\_version](#input\_engine\_version) | Version number of the Redis engine | `string` | `"7.1"` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment (e.g., dev, staging, prod) | `string` | n/a | yes |
| <a name="input_node_type"></a> [node\_type](#input\_node\_type) | The compute and memory capacity of the nodes | `string` | `"cache.t4g.micro"` | no |
| <a name="input_num_node_groups"></a> [num\_node\_groups](#input\_num\_node\_groups) | Number of node groups (shards) for the Redis cluster | `number` | `1` | no |
| <a name="input_parameter_group_name"></a> [parameter\_group\_name](#input\_parameter\_group\_name) | Name of the parameter group to associate with this Redis cluster | `string` | `"default.redis7"` | no |
| <a name="input_port"></a> [port](#input\_port) | Port number for Redis cluster | `number` | `6379` | no |
| <a name="input_project_name"></a> [project\_name](#input\_project\_name) | Name of the project | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | AWS Region where resources will be created | `string` | n/a | yes |
| <a name="input_replicas_per_node_group"></a> [replicas\_per\_node\_group](#input\_replicas\_per\_node\_group) | Number of replica nodes in each node group | `number` | `1` | no |
| <a name="input_ssm_database_subnet_ids"></a> [ssm\_database\_subnet\_ids](#input\_ssm\_database\_subnet\_ids) | IDs das subredes de banco de dados | `list(string)` | n/a | yes |
| <a name="input_ssm_vpc_id"></a> [ssm\_vpc\_id](#input\_ssm\_vpc\_id) | ID do VPC | `string` | n/a | yes |

## Outputs

No outputs.  
<!-- END_TF_DOCS -->