project_name = "gladpe"
environment  = "prod"
aws_region   = "ap-southeast-1"

# ── VPC ───────────────────────────────────────────────────────────────────────
vpc_cidr = "10.0.0.0/16"
azs      = ["ap-southeast-1a", "ap-southeast-1b", "ap-southeast-1c"]

public_subnet_cidrs   = ["10.0.0.0/24", "10.0.1.0/24", "10.0.2.0/24"]
private_subnet_cidrs  = ["10.0.10.0/24", "10.0.11.0/24", "10.0.12.0/24"]
database_subnet_cidrs = ["10.0.20.0/24", "10.0.21.0/24", "10.0.22.0/24"]

# Single NAT GW due to account EIP limit (5 per region). Increase limit via
# AWS Support to switch back to false for full HA.
single_nat_gateway = true

# ── EKS ───────────────────────────────────────────────────────────────────────
eks_cluster_version     = "1.31"
eks_node_instance_types = ["t3.medium"]
eks_node_min_size       = 2
eks_node_max_size       = 10
eks_node_desired_size   = 3

# Restrict this to your office/VPN CIDR in production
eks_endpoint_public_access_cidrs = ["0.0.0.0/0"]

# ── Aurora ────────────────────────────────────────────────────────────────────
aurora_database_name  = "gladpe"
aurora_engine_version = "16.4"
aurora_instance_class = "db.r7g.large"
aurora_instance_count = 1

# ── Redis OSS ─────────────────────────────────────────────────────────────────
valkey_node_type    = "cache.t4g.small"
valkey_num_clusters = 2

# ── S3 ────────────────────────────────────────────────────────────────────────
# Must be globally unique — rename as needed
app_bucket_name = "gladpe-prod-app-assets"
