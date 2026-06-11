output "cluster_identifier" {
  description = "Aurora cluster identifier"
  value       = aws_rds_cluster.this.cluster_identifier
}

output "cluster_endpoint" {
  description = "Writer endpoint for the Aurora cluster"
  value       = aws_rds_cluster.this.endpoint
}

output "reader_endpoint" {
  description = "Read-only endpoint for the Aurora cluster"
  value       = aws_rds_cluster.this.reader_endpoint
}

output "cluster_arn" {
  description = "ARN of the Aurora cluster"
  value       = aws_rds_cluster.this.arn
}

output "database_name" {
  description = "Name of the default database"
  value       = aws_rds_cluster.this.database_name
}

output "master_username" {
  description = "Master username for the cluster"
  value       = aws_rds_cluster.this.master_username
}

output "master_user_secret_arn" {
  description = "ARN of the Secrets Manager secret holding the master password"
  value       = aws_rds_cluster.this.master_user_secret[0].secret_arn
}

output "security_group_id" {
  description = "Security group ID for the Aurora cluster"
  value       = aws_security_group.aurora.id
}

output "port" {
  description = "Aurora PostgreSQL port"
  value       = aws_rds_cluster.this.port
}
