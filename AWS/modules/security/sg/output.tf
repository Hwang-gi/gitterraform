output "bastion_sg" {
  value = aws_security_group.bastion_sg.name
}

output "manage_eks_sg" {
  value = aws_security_group.manage_eks.name
}

output "manage_efs_sg" {
  value = aws_security_group.manage_efs.name
}

output "rds_sg" {
  value = aws_security_group.rds_sg.name
}

output "efs_sg" {
  value = aws_security_group.efs_sg.name
}

output "redis_sg" {
  value = aws_security_group.redis_sg.name
}
