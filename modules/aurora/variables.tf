variable "project_name" {
  description = "Project name used as a prefix for all resources"
  type        = string
}

variable "environment" {
  description = "Deployment environment"
  type        = string
}

variable "cluster_identifier" {
  description = "Identifier for the Aurora cluster"
  type        = string
}

variable "engine_version" {
  description = "Aurora PostgreSQL engine version"
  type        = string
  default     = "16.4"
}

variable "database_name" {
  description = "Name of the default database created at cluster creation"
  type        = string
}

variable "master_username" {
  description = "Master DB username"
  type        = string
  default     = "dbadmin"
}

variable "instance_class" {
  description = "Aurora instance class"
  type        = string
  default     = "db.r7g.large"
}

variable "instance_count" {
  description = "Number of instances in the cluster (1 writer + N-1 readers)"
  type        = number
  default     = 2
}

variable "vpc_id" {
  description = "VPC ID where Aurora is deployed"
  type        = string
}

variable "db_subnet_group_name" {
  description = "Name of the DB subnet group"
  type        = string
}

variable "allowed_security_group_ids" {
  description = "Security group IDs allowed to connect to Aurora (e.g. EKS node SG)"
  type        = list(string)
  default     = []
}

variable "allowed_cidr_blocks" {
  description = "CIDR blocks allowed to connect to Aurora"
  type        = list(string)
  default     = []
}

variable "backup_retention_period" {
  description = "Days to retain automated backups"
  type        = number
  default     = 7
}

variable "preferred_backup_window" {
  description = "Daily time range for automated backups (UTC)"
  type        = string
  default     = "03:00-04:00"
}

variable "preferred_maintenance_window" {
  description = "Weekly time range for maintenance (UTC)"
  type        = string
  default     = "sun:05:00-sun:06:00"
}

variable "deletion_protection" {
  description = "Enable deletion protection on the cluster"
  type        = bool
  default     = true
}

variable "skip_final_snapshot" {
  description = "Skip final snapshot when deleting the cluster"
  type        = bool
  default     = false
}

variable "storage_encrypted" {
  description = "Enable storage encryption at rest"
  type        = bool
  default     = true
}

variable "tags" {
  description = "Additional tags to apply to all resources"
  type        = map(string)
  default     = {}
}
