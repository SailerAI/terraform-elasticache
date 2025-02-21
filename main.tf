resource "aws_elasticache_replication_group" "main" {
  # Unique identifier for the replication group
  replication_group_id          = format("%s-%s-redis", var.project_name, var.environment)
  description                   = "Redis replication group for ${var.project_name} in ${var.environment}"
  
  # Basic Redis configuration
  engine                        = "redis"
  engine_version                = var.engine_version
  node_type                     = var.node_type
  parameter_group_name          = var.parameter_group_name
  port                          = var.port
  
  # Cluster configuration
  num_node_groups               = var.num_node_groups              # Number of shards (node groups) for Cluster Mode
  replicas_per_node_group      = var.replicas_per_node_group     # Number of read replicas per shard
  
  # High availability settings
  automatic_failover_enabled    = true                            # Enables automatic failover to replica nodes
  multi_az_enabled             = true                            # Distributes nodes across multiple AZs for redundancy
  
  # Security settings
  transit_encryption_enabled    = true                            # Encrypts data in transit using TLS
  at_rest_encryption_enabled   = true                            # Encrypts data at rest
  
  # Network configuration
  subnet_group_name            = aws_elasticache_subnet_group.main.name
  security_group_ids          = [aws_security_group.main.id]
  apply_immediately           = true                            # Apply changes immediately instead of next maintenance window

  # Logging configuration
  log_delivery_configuration {
    destination_type = "cloudwatch-logs"                        # Sends logs to CloudWatch Logs
    log_format       = "json"                                   # Log format as JSON for better parsing
    log_type         = "engine-log"                            # Redis engine logs
    destination      = aws_cloudwatch_log_group.redis_logs.name
  }

  tags = {
    Project     = var.project_name
    Environment = var.environment
  }
}

resource "aws_elasticache_subnet_group" "main" {
  # Subnet group for Redis cluster network placement
  name       = format("%s-%s", var.project_name, var.environment)
  subnet_ids = data.aws_ssm_parameter.database_subnet_ids[*].value
  
  tags = {
    Name = "My Elasticcache subnet group"
  }
}

resource "aws_security_group" "main" {
  # Security group to control Redis cluster network access
  name = format("%s-%s-redis", var.project_name, var.environment)
  vpc_id = data.aws_ssm_parameter.vpc_id.value

  ingress {
    from_port = 6379                                           # Default Redis port
    to_port   = 6379
    protocol  = "tcp"
    cidr_blocks = [
      "0.0.0.0/0"                                             # WARNING: Consider restricting this to specific IP ranges
    ]
  }

  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"                                          # Allows all outbound traffic
    cidr_blocks = [
      "0.0.0.0/0"
    ]
  }
}

resource "aws_cloudwatch_log_group" "redis_logs" {
  # Log group for Redis engine logs
  name              = format("/%s/%s/redis", var.project_name, var.environment)
  retention_in_days = 7                                       # Logs are retained for 7 days
  tags = {
    Project     = var.project_name
    Environment = var.environment
  }
}