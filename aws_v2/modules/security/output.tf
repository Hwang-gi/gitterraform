output "sg_bastion_id" {
  value = aws_security_group.SG_BASTION.id
}

output "sg_eks_id" {
  value = aws_security_group.SG_EKS.id
}

output "sg_eks_managed_id" {
  value = aws_security_group.SG_EKS-MANAGED-SERVER.id
}

output "sg_efs_id" {
  value = aws_security_group.SG_EFS.id
}

output "sg_efs_managed_id" {
  value = aws_security_group.SG_EFS_MANAGED_SERVER.id
}

output "sg_node_id" {
  value = aws_security_group.SG_NODE.id
}

output "sg_rds_id" {
  value = aws_security_group.SG_RDS.id
}

output "sg_argocd_id" {
  value = aws_security_group.SG_RDS.id
}

output "sg_redis_id" {
  value = aws_security_group.SG_REDIS.id
}

output "sg_node_name" {
  value = aws_security_group.SG_NODE.name
}
