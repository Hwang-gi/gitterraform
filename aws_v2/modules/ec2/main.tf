resource "aws_instance" "BASTION" {
  for_each = toset(["0", "1"])

  ami = var.ubuntu_ami
  instance_type = var.micro_type
  subnet_id = var.bastion_subnet_ids[tonumber(each.value)]
  vpc_security_group_ids = [var.sg_bastion_id]

  key_name = var.key_pair_name

  tags = {
    Name = "${var.vpc_prefix}-BASTION-PUB-0${each.key + 1}"
  }
}

resource "aws_instance" "EKS_MANAGED_SERVER" {
  for_each = toset(["0", "1"])
  ami = var.ubuntu_ami
  instance_type = var.micro_type
  subnet_id = var.eks_managed_subnet_ids[tonumber(each.value)]
  vpc_security_group_ids = [var.sg_eks_managed_id]

  key_name = var.key_pair_name

  tags = {
    Name = "${var.vpc_prefix}-EKS-MANAGED-PRI-0${each.key + 1}"
  }
}

resource "aws_instance" "EFS_MANAGED_SERVER" {
  ami = var.ubuntu_ami
  instance_type = var.micro_type
  subnet_id = var.efs_managed_subnet_id
  vpc_security_group_ids = [var.sg_efs_managed_id]

  key_name = var.key_pair_name

  tags = {
    Name = "${var.vpc_prefix}-EFS-MANAGED-PRI-2A"
  }
}

resource "aws_instance" "ARGOCD_MANAGED_SERVER" {
  ami = var.ubuntu_ami
  instance_type = var.micro_type
  subnet_id = var.argocd_subnet_id
  vpc_security_group_ids = [var.sg_argocd_id]

  key_name = var.key_pair_name

  tags = {
    Name = "${var.vpc_prefix}-ARGOCD-MANAGED-PRI-2C"
  }
}
