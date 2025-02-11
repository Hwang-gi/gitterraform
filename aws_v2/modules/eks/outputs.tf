output "eks_endpoint" {
  value = aws_eks_cluster.default.endpoint
}

output "eks_id" {
  value = aws_eks_cluster.default.id
}
