output "node_group_id" {
  description = "EKS node group ID"
  value       = aws_eks_node_group.this.id
}

output "node_group_arn" {
  description = "EKS node group ARN"
  value       = aws_eks_node_group.this.arn
}

output "node_group_status" {
  description = "Status of the EKS node group"
  value       = aws_eks_node_group.this.status
}

output "node_role_arn" {
  description = "IAM role ARN for the worker nodes"
  value       = aws_iam_role.node.arn
}
