output "vpc_id" {
  value = aws_vpc.this.id
}

output "vpc_prefix" {
  value = var.vpc_prefix
}

output "eks_name" {
  value = var.cluster_name
}

output "vpc_cidr" {
  value = var.vpc_cidr
}

output "bastion_subnet_ids" {
  value = local.bastion_subnet_ids
}

output "eks_managed_subnet_ids" {
  value = local.eks_managed_subnet_ids
}

output "eks_node_subnet_ids" {
  value = local.node_subnet_ids
}

output "rds_subnet_ids" {
  value = local.rds_subnet_ids
}

output "efs_managed_subnet_id" {
  value = aws_subnet.PRI_EFS_MANAGED_SERVER_2A.id
}

output "argocd_subnet_id" {
  value = aws_subnet.PRI_ARGOCD_MANAGED_SERVER_2C.id
}

output "igw_id" {
  value = aws_internet_gateway.IGW.id
}

output "ngw_ids" {
  value = local.nat_gw_ids
}
