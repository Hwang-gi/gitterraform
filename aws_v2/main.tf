module "vpc" {
  source                  = "./modules/vpc"

  vpc_prefix              = "stg"
  vpc_cidr                = "10.0.0.0/16"
  default_vpc_cidr        = "10.1.0.0/16"
  cluster_name            = "STG-Cluster"
  az                      = ["ap-northeast-2a", "ap-northeast-2c"]
}

module "security" {
  source                  = "./modules/security"

  vpc_id                  = module.vpc.vpc_id
  vpc_prefix              = module.vpc.vpc_prefix
}

# module "ec2" {
#   source                  = "./modules/ec2"

#   key_pair_name = "tf-keypair"
#   vpc_id                  = module.vpc.vpc_id
#   vpc_prefix              = module.vpc.vpc_prefix
#   vpc_cidr                = module.vpc.vpc_cidr

#   ngw_ids                 = values(module.vpc.ngw_ids)

#   bastion_subnet_ids      = values(module.vpc.bastion_subnet_ids)
#   eks_managed_subnet_ids  = values(module.vpc.eks_managed_subnet_ids)
#   efs_managed_subnet_id   = module.vpc.efs_managed_subnet_id
#   argocd_subnet_id        = module.vpc.argocd_subnet_id

#   sg_bastion_id           = module.security.sg_bastion_id
#   sg_eks_managed_id       = module.security.sg_eks_managed_id
#   sg_efs_managed_id       = module.security.sg_efs_managed_id
#   sg_argocd_id            = module.security.sg_argocd_id
# }

# module "storage" {
#   source = "./modules/stroage"

#   vpc_prefix = module.vpc.vpc_prefix
#   rds_subnet_ids = values(module.vpc.rds_subnet_ids)
#   node_subnet_ids = module.vpc.eks_node_subnet_ids
#   rds_sg_id = module.security.sg_rds_id
#   efs_sg_id = module.security.sg_efs_id
# }

module "iam" {
  source = "./modules/iam"

  eks_name = module.vpc.eks_name
  eks_id = module.eks.eks_id
}

module "eks" {
  source = "./modules/eks"

  node_subnets = values(module.vpc.eks_node_subnet_ids)
  kubernetes_version = "1.31"
  eks_name = module.vpc.eks_name
  eks_sg_id = module.security.sg_eks_id
  eks_role_arn = module.iam.eks_role_arn
  eks_role_name = module.iam.eks_role_name
  node_role_arn = module.iam.node_role_arn
  node_role_name = module.iam.node_role_name
  node_sg_id = module.security.sg_node_id
}

module "kubernetes" {
  source = "./modules/kubernetes"

  eks_name = module.vpc.eks_name
}
