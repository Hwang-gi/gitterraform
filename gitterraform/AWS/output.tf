output "vpc_id" {
  value = aws_vpc.this.id
}

output "eks_endpoint" {
  value = aws_eks_cluster.eks_cluster.endpoint
}

output "rds_endpoint" {
  value = aws_db_instance.rds-master.endpoint
}

output "efs_fs_id" {
  value = aws_efs_file_system.efs.id
}
