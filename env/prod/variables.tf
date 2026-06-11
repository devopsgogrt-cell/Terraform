variable "project_name" {
  description = "Project name used as a prefix for all resources"
  type        = string
}

variable "environment" {
  description = "Deployment environment"
  type        = string
  default     = "prod"
}

variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "ap-southeast-1"
}

# ── VPC ───────────────────────────────────────────────────────────────────────

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "azs" {
  description = "Availability zones"
  type        = list(string)
  default     = ["ap-southeast-1a", "ap-southeast-1b", "ap-southeast-1c"]
}

variable "public_subnet_cidrs" {
  type    = list(string)
  default = ["10.0.0.0/24", "10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnet_cidrs" {
  type    = list(string)
  default = ["10.0.10.0/24", "10.0.11.0/24", "10.0.12.0/24"]
}

variable "database_subnet_cidrs" {
  type    = list(string)
  default = ["10.0.20.0/24", "10.0.21.0/24", "10.0.22.0/24"]
}

variable "single_nat_gateway" {
  description = "Use a single NAT gateway (set true only to reduce cost in non-prod)"
  type        = bool
  default     = false
}

# ── EKS ───────────────────────────────────────────────────────────────────────

variable "eks_cluster_version" {
  description = "Kubernetes version for the EKS cluster"
  type        = string
  default     = "1.31"
}

variable "eks_node_instance_types" {
  description = "EC2 instance types for the default node group"
  type        = list(string)
  default     = ["m5.large"]
}

variable "eks_node_min_size" {
  type    = number
  default = 2
}

variable "eks_node_max_size" {
  type    = number
  default = 10
}

variable "eks_node_desired_size" {
  type    = number
  default = 3
}

variable "eks_endpoint_public_access_cidrs" {
  description = "CIDRs allowed to reach the public EKS API endpoint"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

# ── Aurora ────────────────────────────────────────────────────────────────────

variable "aurora_database_name" {
  description = "Default database name for Aurora"
  type        = string
}

variable "aurora_instance_class" {
  description = "Aurora instance class"
  type        = string
  default     = "db.r7g.large"
}

variable "aurora_instance_count" {
  description = "Number of Aurora instances (writer + readers)"
  type        = number
  default     = 2
}

variable "aurora_engine_version" {
  description = "Aurora PostgreSQL engine version"
  type        = string
  default     = "16.4"
}

# ── Valkey ────────────────────────────────────────────────────────────────────

variable "valkey_node_type" {
  description = "ElastiCache node type for Valkey"
  type        = string
  default     = "cache.r7g.large"
}

variable "valkey_num_clusters" {
  description = "Number of cache clusters (1 primary + replicas)"
  type        = number
  default     = 2
}

# ── S3 ────────────────────────────────────────────────────────────────────────

variable "app_bucket_name" {
  description = "Name for the application S3 bucket (must be globally unique)"
  type        = string
}
