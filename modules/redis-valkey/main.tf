locals {
  common_tags = merge(var.tags, {
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "terraform"
  })
}

# ── Security Group ────────────────────────────────────────────────────────────

resource "aws_security_group" "valkey" {
  name        = "${var.replication_group_id}-sg"
  description = "Security group for Valkey replication group ${var.replication_group_id}"
  vpc_id      = var.vpc_id

  ingress {
    description     = "Valkey from allowed security groups"
    from_port       = var.port
    to_port         = var.port
    protocol        = "tcp"
    security_groups = var.allowed_security_group_ids
  }

  dynamic "ingress" {
    for_each = length(var.allowed_cidr_blocks) > 0 ? [1] : []
    content {
      description = "Valkey from allowed CIDRs"
      from_port   = var.port
      to_port     = var.port
      protocol    = "tcp"
      cidr_blocks = var.allowed_cidr_blocks
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(local.common_tags, { Name = "${var.replication_group_id}-sg" })
}

# ── ElastiCache Replication Group (Valkey) ────────────────────────────────────

resource "aws_elasticache_replication_group" "this" {
  replication_group_id = var.replication_group_id
  description          = var.description

  engine         = var.engine
  engine_version = var.engine_version
  node_type      = var.node_type
  port           = var.port

  num_cache_clusters         = var.num_cache_clusters
  automatic_failover_enabled = var.automatic_failover_enabled
  multi_az_enabled           = var.multi_az_enabled

  subnet_group_name  = var.subnet_group_name
  security_group_ids = [aws_security_group.valkey.id]

  at_rest_encryption_enabled = var.at_rest_encryption_enabled
  transit_encryption_enabled = var.transit_encryption_enabled

  maintenance_window       = var.maintenance_window
  snapshot_retention_limit = var.snapshot_retention_limit
  snapshot_window          = var.snapshot_window

  apply_immediately = false

  tags = merge(local.common_tags, { Name = var.replication_group_id })
}
