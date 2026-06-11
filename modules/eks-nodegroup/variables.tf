variable "project_name" {
  description = "Project name used as a prefix for all resources"
  type        = string
}

variable "environment" {
  description = "Deployment environment"
  type        = string
}

variable "cluster_name" {
  description = "Name of the EKS cluster this node group belongs to"
  type        = string
}

variable "node_group_name" {
  description = "Name of the managed node group"
  type        = string
}

variable "subnet_ids" {
  description = "Private subnet IDs for placing worker nodes"
  type        = list(string)
}

variable "instance_types" {
  description = "List of EC2 instance types for worker nodes"
  type        = list(string)
  default     = ["m5.large"]
}

variable "ami_type" {
  description = "AMI type for worker nodes (AL2023_x86_64_STANDARD, AL2_x86_64, BOTTLEROCKET_x86_64)"
  type        = string
  default     = "AL2023_x86_64_STANDARD"
}

variable "capacity_type" {
  description = "Capacity type: ON_DEMAND or SPOT"
  type        = string
  default     = "ON_DEMAND"
  validation {
    condition     = contains(["ON_DEMAND", "SPOT"], var.capacity_type)
    error_message = "capacity_type must be ON_DEMAND or SPOT."
  }
}

variable "disk_size" {
  description = "Root EBS disk size in GiB for worker nodes"
  type        = number
  default     = 50
}

variable "min_size" {
  description = "Minimum number of nodes in the group"
  type        = number
  default     = 1
}

variable "max_size" {
  description = "Maximum number of nodes in the group"
  type        = number
  default     = 5
}

variable "desired_size" {
  description = "Desired number of nodes in the group"
  type        = number
  default     = 2
}

variable "labels" {
  description = "Kubernetes labels to apply to nodes"
  type        = map(string)
  default     = {}
}

variable "taints" {
  description = "Kubernetes taints to apply to nodes"
  type = list(object({
    key    = string
    value  = optional(string)
    effect = string
  }))
  default = []
}

variable "tags" {
  description = "Additional tags to apply to all resources"
  type        = map(string)
  default     = {}
}
