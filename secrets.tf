resource "aws_secretsmanager_secret" "redis_primary_endpoint" {
  name = "REDIS__HOST"
}

resource "aws_secretsmanager_secret_version" "redis_primary_endpoint" {
  secret_id     = aws_secretsmanager_secret.redis.id
  secret_string = aws_elasticache_replication_group.main.primary_endpoint_address
}