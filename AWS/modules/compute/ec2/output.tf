output "bastion_ec2" {
  value  = element(aws_instance.bastion.tags, count.index)
}

output "manage_eks_ec2" {
  value = aws_instance.manage_eks.tags
}

output "manage_efs_ec2" {
  value = aws_instance.manage_efs.tags
}
