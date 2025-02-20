#resource "aws_elasticache_cluster" "main" {
#  cluster_id           = format("%s-%s-redis", var.project_name, var.environment)
#  engine               = var.engine
#  node_type            = var.node_type
#  num_cache_nodes      = var.num_cache_nodes
#  parameter_group_name = var.parameter_group_name
#  engine_version       = var.engine_version
#  port                 = var.port
#  subnet_group_name    = aws_elasticache_subnet_group.main.id
#  security_group_ids   = [ aws_security_group.main.id] 
#  transit_encryption_enabled = true
#  preferred_availability_zones = var.azs
#}

resource "aws_elasticache_replication_group" "main" {
  replication_group_id          = format("%s-%s-redis", var.project_name, var.environment)
  description = "Redis replication group for ${var.project_name} in ${var.environment}"
  engine                        = "redis"
  engine_version                = var.engine_version
  node_type                     = var.node_type
  parameter_group_name          = var.parameter_group_name
  port                          = var.port
  #num_cache_clusters            = var.num_cache_nodes                   # Total de nós (1 primário + 1 réplica)
  num_node_groups               = var.num_node_groups
  replicas_per_node_group       = var.replicas_per_node_group                    # Número de réplicas (Cluster Mode Disabled)
  automatic_failover_enabled    = true                # Failover automático habilitado
  multi_az_enabled              = true                # Nós distribuídos em diferentes AZs
  transit_encryption_enabled    = true                # Criptografia em trânsito habilitada
  at_rest_encryption_enabled    = true
  subnet_group_name = aws_elasticache_subnet_group.main.name
  security_group_ids = [aws_security_group.main.id]
apply_immediately = true

 log_delivery_configuration {
    destination_type = "cloudwatch-logs" # ou "s3" para S3
    log_format       = "json"
    log_type         = "engine-log"
    destination      = aws_cloudwatch_log_group.redis_logs.name

  }


  tags = {
    Project     = var.project_name
    Environment = var.environment
  }
}



resource "aws_elasticache_subnet_group" "main" {
  name       = format("%s-%s", var.project_name, var.environment)
  subnet_ids = data.aws_ssm_parameter.database_subnet_ids[*].value
  
  tags = {
    Name = "My Elasticcache subnet group"
  }
}


resource "aws_security_group" "main" {
  name = format("%s-%s-redis", var.project_name, var.environment)

  vpc_id = data.aws_ssm_parameter.vpc_id.value

  ingress {
    from_port = 6379
    to_port   = 6379
    protocol  = "tcp"
    cidr_blocks = [
      "0.0.0.0/0"
    ]
  }

  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = [
      "0.0.0.0/0"
    ]
  }
}


resource "aws_cloudwatch_log_group" "redis_logs" {
  name = format("/%s/%s/redis", var.project_name, var.environment) 
  retention_in_days = 7
  tags = {
    Project     = var.project_name
    Environment = var.environment
  }
}