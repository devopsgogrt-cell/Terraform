# ── VPC ───────────────────────────────────────────────────────────────────────

output "vpc_id" {
  description = "VPC ID"
  value       = module.vpc.vpc_id
}

output "private_subnet_ids" {
  description = "Private subnet IDs"
  value       = module.vpc.private_subnet_ids
}

output "public_subnet_ids" {
  description = "Public subnet IDs"
  value       = module.vpc.public_subnet_ids
}

# ── EKS ───────────────────────────────────────────────────────────────────────

output "eks_cluster_name" {
  description = "EKS cluster name"
  value       = module.eks_cluster.cluster_name
}

output "eks_cluster_endpoint" {
  description = "EKS API server endpoint"
  value       = module.eks_cluster.cluster_endpoint
}

output "eks_cluster_oidc_issuer_url" {
  description = "OIDC issuer URL for IRSA"
  value       = module.eks_cluster.cluster_oidc_issuer_url
}

output "eks_oidc_provider_arn" {
  description = "OIDC provider ARN for IRSA"
  value       = module.eks_cluster.oidc_provider_arn
}

output "eks_configure_kubectl" {
  description = "Command to configure kubectl"
  value       = "aws eks update-kubeconfig --region ${var.aws_region} --name ${module.eks_cluster.cluster_name}"
}

# ── Aurora ────────────────────────────────────────────────────────────────────

output "aurora_cluster_endpoint" {
  description = "Aurora writer endpoint"
  value       = module.aurora.cluster_endpoint
}

output "aurora_reader_endpoint" {
  description = "Aurora reader endpoint"
  value       = module.aurora.reader_endpoint
}

output "aurora_database_name" {
  description = "Aurora default database name"
  value       = module.aurora.database_name
}

output "aurora_master_user_secret_arn" {
  description = "Secrets Manager ARN holding the Aurora master password"
  value       = module.aurora.master_user_secret_arn
  sensitive   = true
}

# ── Valkey ────────────────────────────────────────────────────────────────────

output "valkey_primary_endpoint" {
  description = "Valkey primary endpoint"
  value       = module.valkey.primary_endpoint_address
}

output "valkey_reader_endpoint" {
  description = "Valkey reader endpoint"
  value       = module.valkey.reader_endpoint_address
}

# ── S3 ────────────────────────────────────────────────────────────────────────

output "app_bucket_name" {
  description = "Application S3 bucket name"
  value       = module.s3_app.bucket_id
}

output "app_bucket_arn" {
  description = "Application S3 bucket ARN"
  value       = module.s3_app.bucket_arn
}
