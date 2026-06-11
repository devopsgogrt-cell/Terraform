variable "project_name" {
  description = "Project name used as a prefix for all resources"
  type        = string
}

variable "environment" {
  description = "Deployment environment"
  type        = string
}

variable "replication_group_id" {
  description = "Unique ID for the ElastiCache replication group"
  type        = string
}

variable "description" {
  description = "Description for the replication group"
  type        = string
  default     = "Valkey replication group"
}

variable "engine" {
  description = "ElastiCache engine: redis or valkey"
  type        = string
  default     = "redis"
  validation {
    condition     = contains(["redis", "valkey"], var.engine)
    error_message = "engine must be redis or valkey."
  }
}

variable "engine_version" {
  description = "Engine version (e.g. 7.1.0 for Redis OSS, 7.2 for Valkey)"
  type        = string
  default     = "7.1"
}

variable "node_type" {
  description = "ElastiCache node instance type"
  type        = string
  default     = "cache.r7g.large"
}

variable "num_cache_clusters" {
  description = "Number of cache clusters (1 primary + N-1 replicas)"
  type        = number
  default     = 2
}

variable "automatic_failover_enabled" {
  description = "Enable automatic failover (requires num_cache_clusters >= 2)"
  type        = bool
  default     = true
}

variable "multi_az_enabled" {
  description = "Enable Multi-AZ deployment"
  type        = bool
  default     = true
}

variable "port" {
  description = "Port number for the cache cluster"
  type        = number
  default     = 6379
}

variable "subnet_group_name" {
  description = "Name of the ElastiCache subnet group"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID where ElastiCache is deployed"
  type        = string
}

variable "allowed_security_group_ids" {
  description = "Security group IDs allowed to connect to ElastiCache (e.g. EKS node SG)"
  type        = list(string)
  default     = []
}

variable "allowed_cidr_blocks" {
  description = "CIDR blocks allowed to connect to ElastiCache"
  type        = list(string)
  default     = []
}

variable "at_rest_encryption_enabled" {
  description = "Enable encryption at rest"
  type        = bool
  default     = true
}

variable "transit_encryption_enabled" {
  description = "Enable in-transit TLS encryption"
  type        = bool
  default     = true
}

variable "maintenance_window" {
  description = "Weekly time range for maintenance (UTC)"
  type        = string
  default     = "sun:05:00-sun:06:00"
}

variable "snapshot_retention_limit" {
  description = "Number of days to retain automatic snapshots (0 disables snapshots)"
  type        = number
  default     = 7
}

variable "snapshot_window" {
  description = "Daily time range for automatic snapshots (UTC)"
  type        = string
  default     = "03:00-04:00"
}

variable "tags" {
  description = "Additional tags to apply to all resources"
  type        = map(string)
  default     = {}
}
