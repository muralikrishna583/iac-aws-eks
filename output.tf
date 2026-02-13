output "cluster_endpoint" {
  description = "EKS cluster endpoint"
  value       = aws_eks_cluster.main.endpoint
}

output "cluster_name" {
  description = "EKS cluster name"
  value       = aws_eks_cluster.main.name
}

output "cluster_certificate_authority_data" {
  description = "Base64-encoded certificate-authority data for the EKS cluster (useful for kubeconfig)"
  value       = aws_eks_cluster.main.certificate_authority[0].data
}

output "oidc_issuer" {
  description = "OIDC issuer URL for the EKS cluster (useful for IRSA)")
  value       = aws_eks_cluster.main.identity[0].oidc[0].issuer
}

output "node_role_arn" {
  description = "IAM role ARN used by node groups"
  value       = aws_iam_role.node.arn
}

output "oidc_provider_arn" {
  description = "ARN of the created IAM OIDC provider (null if not created)"
  value       = try(aws_iam_openid_connect_provider.this[0].arn, null)
}

output "kubeconfig" {
  description = "Kubeconfig contents for the cluster (useful to write to a file)"
  value       = local.kubeconfig
  sensitive   = true
}

output "kubeconfig_path" {
  description = "Path where kubeconfig is written when `write_kubeconfig` is true"
  value       = var.kubeconfig_path
}