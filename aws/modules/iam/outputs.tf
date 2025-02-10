output "eks_role_arn" {
  value = aws_iam_role.eks_role.arn
}

output "eks_role_name" {
  value = aws_iam_role.eks_role.name
}

output "node_role_arn" {
  value = aws_iam_role.node_role.arn
}

output "node_role_name" {
  value = aws_iam_role.node_role.name
}

output "ca_role_name" {
  value = aws_iam_role.autoscaler_role.name
}

output "efs_csi_driver_role_name" {
  value = aws_iam_role.efs_csi_driver_role.name
}

output "alb_role_name" {
  value = aws_iam_role.aws_load_balancer_controller_role.name
}

output "oidc_url" {
  value = aws_iam_openid_connect_provider.default.url
}
