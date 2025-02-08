# subnet type: map type ({} 기호 사용)
# -> map, set type에서 for_each 사용 가능
# map type은 keyd와 value로 구성, list value

locals {
  subnet_cidr_blocks = {
    "PUB_BASTION_2A" = cidrsubnet(var.vpc_cidr, 8, 0)
    "PUB_BASTION_2C" = cidrsubnet(var.vpc_cidr, 8, 1)
    "PRI_EKS_MANAGED_SERVER_2A" = cidrsubnet(var.vpc_cidr, 8, 2)
    "PRI_EKS_MANAGED_SERVER_2C" = cidrsubnet(var.vpc_cidr, 8, 3)
    "PRI_NODE_2A" = cidrsubnet(var.vpc_cidr, 8, 11)
    "PRI_NODE_2C" = cidrsubnet(var.vpc_cidr, 8, 12)
    "PRI_RDS_2A" = cidrsubnet(var.vpc_cidr, 8, 21)
    "PRI_RDS_2C" = cidrsubnet(var.vpc_cidr, 8, 22)
  }

  kubernetes_tag = "kubernetes.io/cluster/${var.cluster_name}"

  bastion_subnet_ids = {
    "PUB_BASTION_2A" = aws_subnet.PUB_BASTION["2A"].id
    "PUB_BASTION_2C" = aws_subnet.PUB_BASTION["2C"].id
  }

  eks_managed_subnet_ids = {
    "PRI_EKS_MANAGED_SERVER_2A" = aws_subnet.PRI_EKS_MANAGED_SERVER["2A"].id
    "PRI_EKS_MANAGED_SERVER_2C" = aws_subnet.PRI_EKS_MANAGED_SERVER["2C"].id
  }

  node_subnet_ids = {
    "PRI_NODE_2A" = aws_subnet.PRI_NODE["2A"].id
    "PRI_NODE_2C" = aws_subnet.PRI_NODE["2C"].id
  }

  rds_subnet_ids = {
    "PRI_RDS_2A" = aws_subnet.PRI_RDS["2A"].id
    "PRI_RDS_2C" = aws_subnet.PRI_RDS["2C"].id
  }

  nat_gw_ids = {
    "2A" = aws_nat_gateway.NGW["2A"].id
    "2C" = aws_nat_gateway.NGW["2C"].id
  }

  route_table_associations = {
    "RT_ASSOCIATE_PUB_BASTION_2A" = {
      subnet_id      = local.bastion_subnet_ids["PUB_BASTION_2A"]
      route_table_id = aws_route_table.RT_PUB.id
    }
    "RT_ASSOCIATE_PUB_BASTION_2C" = {
      subnet_id      = local.bastion_subnet_ids["PUB_BASTION_2C"]
      route_table_id = aws_route_table.RT_PUB.id
    }
    "RT_ASSOCIATE_PRI_EKS_MANAGED_SERVER_2A" = {
      subnet_id      = local.eks_managed_subnet_ids["PRI_EKS_MANAGED_SERVER_2A"]
      route_table_id = aws_route_table.RT_PRI_01.id
    }
    "RT_ASSOCIATE_PRI_EKS_MANAGED_SERVER_2C" = {
      subnet_id      = local.eks_managed_subnet_ids["PRI_EKS_MANAGED_SERVER_2C"]
      route_table_id = aws_route_table.RT_PRI_02.id
    }
    "RT_ASSOCIATE_PRI_EFS_MANAGED_SERVER_2A" = {
      subnet_id      = aws_subnet.PRI_EFS_MANAGED_SERVER_2A.id
      route_table_id = aws_route_table.RT_PRI_01.id
    }
    "RT_ASSOCIATE_ARGOCD_MANAGED_SERVER_2C" = {
      subnet_id      = aws_subnet.PRI_ARGOCD_MANAGED_SERVER_2C.id
      route_table_id = aws_route_table.RT_PRI_02.id
    }
    "RT_ASSOCIATE_PRI_NODE_2A" = {
      subnet_id      = local.node_subnet_ids["PRI_NODE_2A"]
      route_table_id = aws_route_table.RT_PRI_01.id
    }
    "RT_ASSOCIATE_PRI_NODE_2C" = {
      subnet_id      = local.node_subnet_ids["PRI_NODE_2C"]
      route_table_id = aws_route_table.RT_PRI_02.id
    }
    "RT_ASSOCIATE_PRI_RDS_2A" = {
      subnet_id      = local.rds_subnet_ids["PRI_RDS_2A"]
      route_table_id = aws_route_table.RT_PRI_01.id
    }
    "RT_ASSOCIATE_PRI_RDS_2C" = {
      subnet_id      = local.rds_subnet_ids["PRI_RDS_2C"]
      route_table_id = aws_route_table.RT_PRI_02.id
    }
  }
}

resource "aws_vpc" "this" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    "Name" = "${var.vpc_prefix}-VPC"
  }
}

resource "aws_vpc" "default" {
  cidr_block = var.default_vpc_cidr

  tags = {
    Name = "DEFAULT-VPC"
  }
}

resource "aws_subnet" "PUB_BASTION" {
  for_each = toset(["2A", "2C"])

  vpc_id                  = aws_vpc.this.id
  cidr_block              = local.subnet_cidr_blocks["PUB_BASTION_${each.value}"]
  availability_zone       = var.az[each.value == "2A" ? 0 : 1]
  map_public_ip_on_launch = true

  tags = {
    "Name"                              = "${var.vpc_prefix}-PUB-BASTION-${each.value}"
    "kubernetes.io/role/elb"            = "1"
    "${local.kubernetes_tag}"            = "shared"
  }
}

resource "aws_subnet" "PRI_EKS_MANAGED_SERVER" {
  for_each = toset(["2A", "2C"])

  vpc_id                  = aws_vpc.this.id
  cidr_block              = local.subnet_cidr_blocks["PRI_EKS_MANAGED_SERVER_${each.value}"]
  availability_zone       = var.az[each.value == "2A" ? 0 : 1]
  map_public_ip_on_launch = false

  tags = {
    "Name"                              = "${var.vpc_prefix}-PRI-EKS-MANAGED-SERVER-${each.value}"
    "kubernetes.io/role/internal-elb"   = "1"
    "${local.kubernetes_tag}"            = "shared"
  }
}

resource "aws_subnet" "PRI_NODE" {
  for_each = toset(["2A", "2C"])

  vpc_id                  = aws_vpc.this.id
  cidr_block              = local.subnet_cidr_blocks["PRI_NODE_${each.value}"]
  availability_zone       = var.az[each.value == "2A" ? 0 : 1]
  map_public_ip_on_launch = false

  tags = {
    "Name"                              = "${var.vpc_prefix}-PRI-NODE-${each.value}"
    "kubernetes.io/role/internal-elb"   = "1"
    "${local.kubernetes_tag}"            = "owned"
  }
}

resource "aws_subnet" "PRI_RDS" {
  for_each = toset(["2A", "2C"])

  vpc_id                  = aws_vpc.this.id
  cidr_block              = local.subnet_cidr_blocks["PRI_RDS_${each.value}"]
  availability_zone       = var.az[each.value == "2A" ? 0 : 1]
  map_public_ip_on_launch = false

  tags = {
    "Name"                              = "${var.vpc_prefix}-PRI-RDS-${each.value}"
    "kubernetes.io/role/internal-elb"   = "1"
    "${local.kubernetes_tag}"            = "shared"
  }
}

resource "aws_subnet" "PRI_EFS_MANAGED_SERVER_2A" {
  vpc_id                  = aws_vpc.this.id
  cidr_block              = cidrsubnet(var.vpc_cidr, 8, 5)
  availability_zone       = var.az[0]
  map_public_ip_on_launch = false

  tags = {
    "Name"                              = "${var.vpc_prefix}-PRI-EFS-MANAGED-SERVER-2A"
    "kubernetes.io/role/internal-elb"   = "1"
    "${local.kubernetes_tag}"            = "shared"
  }
}

resource "aws_subnet" "PRI_ARGOCD_MANAGED_SERVER_2C" {
  vpc_id                  = aws_vpc.this.id
  cidr_block              = cidrsubnet(var.vpc_cidr, 8, 6)
  availability_zone       = var.az[1]
  map_public_ip_on_launch = false

  tags = {
    "Name"                              = "${var.vpc_prefix}-PRI-ARGOCD-MANAGED-SERVER-2C"
    "kubernetes.io/role/internal-elb"   = "1"
    "${local.kubernetes_tag}"            = "shared"
  }


}
resource "aws_internet_gateway" "IGW" {
  vpc_id = aws_vpc.this.id
  tags = {
    "Name" = "${var.vpc_prefix}-IGW"
  }

}

resource "aws_route_table" "RT_PUB" {
  vpc_id = aws_vpc.this.id

  tags = {
    "Name" = "${var.vpc_prefix}-RT-PUB"
  }
}

resource "aws_route" "RT_PUB_IGW" {
  route_table_id         = aws_route_table.RT_PUB.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.IGW.id
}

resource "aws_eip" "EIP" {
  for_each = toset(["2A", "2C"])
}

resource "aws_nat_gateway" "NGW" {
  for_each = toset(["2A", "2C"])

  allocation_id = aws_eip.EIP[each.key].id
  subnet_id     = local.bastion_subnet_ids["PUB_BASTION_${each.value}"]
  tags = {
    "Name" = "${var.vpc_prefix}-NGW-${each.key}"
  }
}

resource "aws_route_table" "RT_PRI_01" {
  vpc_id = aws_vpc.this.id
  tags = {
    "Name" = "${var.vpc_prefix}-RT-PRI_01"
  }
}

resource "aws_route_table" "RT_PRI_02" {
  vpc_id = aws_vpc.this.id

  tags = {
    "Name" = "${var.vpc_prefix}-RT-PRI-02"
  }

}

resource "aws_route_table_association" "RT_ASSOCIATE" {
  for_each = local.route_table_associations

  subnet_id      = each.value.subnet_id
  route_table_id = each.value.route_table_id
}

resource "aws_route" "RT_PRI_01" {
  route_table_id         = aws_route_table.RT_PRI_01.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.NGW["2A"].id
}

resource "aws_route" "RT_PRI_02" {
  route_table_id         = aws_route_table.RT_PRI_02.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.NGW["2C"].id
}
