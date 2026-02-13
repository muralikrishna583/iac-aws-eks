variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
  validation {
    condition     = length(var.cluster_name) > 0
    error_message = "cluster_name must not be empty"
  }
}

variable "cluster_version" {
  description = "Kubernetes version"
  type        = string
  validation {
    condition     = length(var.cluster_version) > 0
    error_message = "cluster_version must not be empty"
  }
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
  validation {
    condition     = length(var.vpc_id) > 0
    error_message = "vpc_id must not be empty"
  }
}

variable "subnet_ids" {
  description = "Subnet IDs"
  type        = list(string)
  validation {
    condition     = length(var.subnet_ids) > 0
    error_message = "subnet_ids must contain at least one subnet id"
  }
}

variable "node_groups" {
  description = "EKS node group configuration"
  type = map(object({
    instance_types = list(string)
    capacity_type  = string
    scaling_config = object({
      desired_size = number
      max_size     = number
      min_size     = number
    })
  }))
  validation {
    condition     = length(var.node_groups) > 0
    error_message = "node_groups must contain at least one node group configuration"
  }
  validation {
    condition = alltrue([for ng in values(var.node_groups) : ng.scaling_config.min_size <= ng.scaling_config.desired_size && ng.scaling_config.desired_size <= ng.scaling_config.max_size])
    error_message = "For each node_group ensure min_size <= desired_size <= max_size"
  }
}

variable "create_oidc_provider" {
  description = "Whether to create an IAM OIDC provider for the cluster (required for IRSA)"
  type        = bool
  default     = true
}

variable "write_kubeconfig" {
  description = "If true the module will write a kubeconfig file to `kubeconfig_path` using the local provider"
  type        = bool
  default     = false
}

variable "kubeconfig_path" {
  description = "Path where kubeconfig will be written if `write_kubeconfig` is true"
  type        = string
  default     = "./kubeconfig"
}