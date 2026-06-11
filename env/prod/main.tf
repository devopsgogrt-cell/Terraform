locals {
  cluster_name = "${var.project_name}-${var.environment}"
}

# ── VPC ───────────────────────────────────────────────────────────────────────

module "vpc" {
  source = "../../modules/vpc"

  project_name          = var.project_name
  environment           = var.environment
  vpc_cidr              = var.vpc_cidr
  azs                   = var.azs
  public_subnet_cidrs   = var.public_subnet_cidrs
  private_subnet_cidrs  = var.private_subnet_cidrs
  database_subnet_cidrs = var.database_subnet_cidrs
  enable_nat_gateway    = true
  single_nat_gateway    = var.single_nat_gateway
}

# ── EKS Cluster ───────────────────────────────────────────────────────────────

module "eks_cluster" {
  source = "../../modules/eks-cluster"

  project_name    = var.project_name
  environment     = var.environment
  cluster_name    = local.cluster_name
  cluster_version = var.eks_cluster_version
  vpc_id          = module.vpc.vpc_id
  subnet_ids      = module.vpc.private_subnet_ids

  cluster_endpoint_private_access      = true
  cluster_endpoint_public_access       = true
  cluster_endpoint_public_access_cidrs = var.eks_endpoint_public_access_cidrs
}

# ── EKS Node Group ────────────────────────────────────────────────────────────

module "eks_nodegroup" {
  source = "../../modules/eks-nodegroup"

  project_name    = var.project_name
  environment     = var.environment
  cluster_name    = module.eks_cluster.cluster_name
  node_group_name = "general"
  subnet_ids      = module.vpc.private_subnet_ids

  instance_types = var.eks_node_instance_types
  capacity_type  = "ON_DEMAND"
  ami_type       = "AL2023_x86_64_STANDARD"
  disk_size      = 50

  min_size     = var.eks_node_min_size
  max_size     = var.eks_node_max_size
  desired_size = var.eks_node_desired_size
}

# ── CoreDNS addon (must wait for nodes to be ready) ──────────────────────────

resource "aws_eks_addon" "coredns" {
  cluster_name                = module.eks_cluster.cluster_name
  addon_name                  = "coredns"
  resolve_conflicts_on_create = "OVERWRITE"
  resolve_conflicts_on_update = "OVERWRITE"

  tags = {
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "terraform"
  }

  depends_on = [module.eks_nodegroup]
}

# ── Aurora PostgreSQL ─────────────────────────────────────────────────────────

module "aurora" {
  source = "../../modules/aurora"

  project_name       = var.project_name
  environment        = var.environment
  cluster_identifier = "${local.cluster_name}-aurora"
  engine_version     = var.aurora_engine_version
  database_name      = var.aurora_database_name
  instance_class     = var.aurora_instance_class
  instance_count     = var.aurora_instance_count

  vpc_id               = module.vpc.vpc_id
  db_subnet_group_name = module.vpc.db_subnet_group_name

  # Allow EKS cluster security group to reach Aurora
  allowed_security_group_ids = [module.eks_cluster.cluster_security_group_id]

  backup_retention_period = 7
  deletion_protection     = true
  skip_final_snapshot     = false
}

# ── Valkey (ElastiCache) ──────────────────────────────────────────────────────

module "valkey" {
  source = "../../modules/redis-valkey"

  project_name         = var.project_name
  environment          = var.environment
  replication_group_id = "${local.cluster_name}-redis"
  description          = "Redis OSS cache for ${local.cluster_name}"

  engine             = "redis"
  node_type          = var.valkey_node_type
  num_cache_clusters = var.valkey_num_clusters
  engine_version     = "7.1"

  subnet_group_name = module.vpc.elasticache_subnet_group_name
  vpc_id            = module.vpc.vpc_id

  # Allow EKS cluster security group to connect
  allowed_security_group_ids = [module.eks_cluster.cluster_security_group_id]

  at_rest_encryption_enabled = true
  transit_encryption_enabled = true
  automatic_failover_enabled = true
  multi_az_enabled           = true
}

# ── S3 Application Bucket ─────────────────────────────────────────────────────

module "s3_app" {
  source = "../../modules/s3"

  project_name       = var.project_name
  environment        = var.environment
  bucket_name        = var.app_bucket_name
  versioning_enabled = true
  force_destroy      = false

  lifecycle_rules = [
    {
      id      = "transition-to-ia"
      enabled = true
      prefix  = ""
      transition = [
        {
          days          = 90
          storage_class = "STANDARD_IA"
        },
        {
          days          = 365
          storage_class = "GLACIER"
        }
      ]
      noncurrent_version_expiration_days = 30
    }
  ]
}
