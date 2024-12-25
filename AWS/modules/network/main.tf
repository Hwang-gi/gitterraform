resource "aws_vpc" "this" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    "Name" = "${var.vpc_name}-VPC"
  }
}

resource "aws_subnet" "bastion" {
  count                                                 = length(var.availability_zones)
  vpc_id                                                = aws_vpc.this.id
  cidr_block                                            = cidrsubnet(var.vpc_cidr, 8, count.index)
  availability_zone                                     = element(var.availability_zones, count.index)
  map_public_ip_on_launch                               = true
  tags = {
    "Name"                                              = "${var.vpc_name}-PUB-BASTION-${element(var.availability_zones, count.index)}"
    "kubernetes.io/role/elb"                            = "1"
    "kubernetes.io/cluster/${var.vpc_name}-cluster"     = "shared"
  }
}

resource "aws_subnet" "eks_node" {
  count                                                 = length(var.availability_zones)
  vpc_id                                                = aws_vpc.this.id
  cidr_block                                            = cidrsubnet(var.vpc_cidr, 8, count.index)
  availability_zone                                     = element(var.availability_zones, count.index)
  map_public_ip_on_launch                               = false
  tags = {
    "Name"                                              = "${var.vpc_name}-PRI-NODE-${element(var.availability_zones, count.index)}"
    "kubernetes.io/role/internal-elb"                   = "1"
    "kubernetes.io/cluster/${var.vpc_name}-cluster"     = "shared"
  }
}


resource "aws_subnet" "manage_eks" {
  vpc_id                                                = aws_vpc.this.id
  cidr_block                                            = cidrsubnet(var.vpc_cidr, 8, count.index)
  availability_zone                                     = "ap-northeast-2a"
  map_public_ip_on_launch                               = false
  tags = {
    "Name"                                              = "${var.vpc_name}-EKS-MANAGED-2A"
    "kubernetes.io/role/internal-elb"                   = "1"
    "kubernetes.io/cluster/${var.vpc_name}-cluster"     = "shared"
  }
}

resource "aws_subnet" "manage_efs" {
  vpc_id                                                = aws_vpc.this.id
  cidr_block                                            = cidrsubnet(var.vpc_cidr, 8, count.index)
  availability_zone                                     = "ap-northeast-2c"
  map_public_ip_on_launch                               = false
  tags = {
    "Name"                                              = "${var.vpc_name}-EFS-MANAGED-2C"
    "kubernetes.io/role/internal-elb"                   = "1"
    "kubernetes.io/cluster/${var.vpc_name}-cluster"     = "shared"
  }
}

resource "aws_subnet" "rds_group" {
  count                                                 = length(var.availability_zones)
  vpc_id                                                = aws_vpc.this.id
  cidr_block                                            = cidrsubnet(var.vpc_cidr, 8, count.index)
  availability_zone                                     = element(var.availability_zones, count.index)
  map_public_ip_on_launch                               = false
  tags = {
    "Name"                                              = "${var.vpc_name}-RDS-${element(var.availability_zones, count.index)}"
    "kubernetes.io/role/internal-elb"                   = "1"
    "kubernetes.io/cluster/${var.vpc_name}-cluster"     = "shared"
  }
}

resource "aws_db_subnet_group" "rds_group" {
  subnet_ids                                            = [aws_subnet.rds_group[0].id, aws_subnet.rds_group[1].id]

    tags                                                = {
      Name = "${var.vpc_name}-RDS-Subnet-Group"
  }

}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.this.id
  tags = {
    "Name" = "${var.vpc_name}-IGW"
  }

}

resource "aws_eip" "eip-01" {
  domain                                                = vpc
}

resource "aws_eip" "eip-02" {
  domain                                                = vpc
}

resource "aws_nat_gateway" "NGW-01" {
  allocation_id                                         = aws_eip.EIP-01.id
  subnet_id                                             = aws_subnet.bastion[0].id
  tags = {
    "Name" = "${var_vpc_name}-NGW-01"
  }
}

resource "aws_nat_gateway" "NGW-02" {
  allocation_id                                        = aws_eip.EIP-02.id
  subnet_id                                            = aws_subnet.bastion[1].id
  tags = {
    "Name" = "${var.vpc_name}-NGW-02"
  }

}

resource "aws_route_table" "RT-PUB" {
  vpc_id                                               = aws_vpc.this.id

  tags = {
    "Name" = "${var.vpc_name}-RT-PUB"
  }

}

resource "aws_route_table" "RT-PRI-01" {
  vpc_id = aws_vpc.this.id
  tags = {
    "Name" = "${var.vpc_name}-RT-PRI-01"
  }
}

resource "aws_route_table" "RT-PRI-02" {
  vpc_id = aws_vpc.this.id

  tags = {
    "Name" = "${var.vpc_name}-RT-PRI-02"
  }

}

resource "aws_route" "route_pub_internet" {
  route_table_id         = aws_route_table.RT-PUB.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

resource "aws_route" "route_pri_01_nat" {
  route_table_id         = aws_route_table.RT-PRI-01.id
  destination_cidr_block = "0.0.0.0/0"  # 모든 트래픽
  nat_gateway_id         = aws_nat_gateway.NGW-01.id
}

resource "aws_route" "route_pri_02_nat" {
  route_table_id         = aws_route_table.RT-PRI-01.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.NGW-02.id
}


resource "aws_route_table_association" "bastion_01" {
  subnet_id      = aws_subnet.bastion[0].id
  route_table_id = aws_route_table.RT-PUB.id
}

resource "aws_route_table_association" "bastion_02" {
  subnet_id      = aws_subnet.bastion[1].id
  route_table_id = aws_route_table.RT-PUB.id
}

resource "aws_route_table_association" "node_01" {
  subnet_id      = aws_subnet.eks-node[0].id
  route_table_id = aws_route_table.RT-PRI-01.id
}

resource "aws_route_table_association" "eks_node_02" {
  subnet_id      = aws_subnet.eks-node[1].id
  route_table_id = aws_route_table.RT-PRI-02.id
}

resource "aws_route_table_association" "rds_01" {
  subnet_id      = aws_subnet.rds_group[0].id
  route_table_id = aws_route_table.RT-PRI-01.id
}

resource "aws_route_table_association" "rds_02" {
  subnet_id      = aws_subnet.rds_group[1].id
  route_table_id = aws_route_table.RT-PRI-02.id
}

resource "aws_route_table_association" "manage_eks" {
  subnet_id      = aws_subnet.manage_eks.id
  route_table_id = aws_route_table.RT-PRI-02.id
}

resource "aws_route_table_association" "manage_efs" {
  subnet_id      = aws_subnet.manage_efs
  route_table_id = aws_route_table.RT-PRI-02.id
}
