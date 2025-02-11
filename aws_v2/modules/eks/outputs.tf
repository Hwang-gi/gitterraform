output "eks_endpoint" {
  value = aws_eks_cluster.default.endpoint
}

output "eks_id" {
  value = aws_eks_cluster.default.id
}

output "eks_auth" {
  value = aws_eks_cluster_auth.default.name
}
