# public subnet
resource "aws_subnet" "PUB-BASTION-2A" {
  vpc_id                  = aws_vpc.this.id
  cidr_block              = cidrsubnet(var.vpc_cidr, 8, 0)
  availability_zone       = "ap-northeast-2a"
  map_public_ip_on_launch = "true"
  tags = {
    "Name"                              = "${var.vpc_prefix}-PUB-BASTION-2A"
    "kubernetes.io/role/elb"            = "1"
    "kubernetes.io/cluster/${var.vpc_prefix}-Cluster" = "shared"

  }
}

resource "aws_subnet" "PUB-BASTION-2C" {
  vpc_id                  = aws_vpc.this.id
  cidr_block              = cidrsubnet(var.vpc_cidr, 8, 1)
  availability_zone       = "ap-northeast-2c"
  map_public_ip_on_launch = "true"
  tags = {
    "Name"                              = "${var.vpc_prefix}-PUB-BASTION-2C"
    "kubernetes.io/role/elb"            = "1"
    "kubernetes.io/cluster/${var.vpc_prefix}-Cluster" = "shared"

  }
}

# pirvate subnet
resource "aws_subnet" "PRI-EKS-MANAGED-SERVER-2A" {

  vpc_id                  = aws_vpc.this.id
  cidr_block              = cidrsubnet(var.vpc_cidr, 8, 2)
  availability_zone       = "ap-northeast-2a"
  map_public_ip_on_launch = false
  tags = {
    "Name"                              = "${var.vpc_prefix}-PRI-EKS-MANAGED-SERVER-2A"
    "kubernetes.io/role/internal-elb"   = "1"
    "kubernetes.io/cluster/${var.vpc_prefix}-Cluster" = "shared"

  }
}

resource "aws_subnet" "PRI-EFS-MANAGED-SERVER-2A" {
  vpc_id                  = aws_vpc.this.id
  cidr_block              = cidrsubnet(var.vpc_cidr, 8, 3)
  availability_zone       = "ap-northeast-2a"
  map_public_ip_on_launch = false

  tags = {
    "Name"                              = "${var.vpc_prefix}-PRI-EFS-MANAGED-SERVER-2A"
    "kubernetes.io/role/internal-elb"   = "1"
    "kubernetes.io/cluster/${var.vpc_prefix}-Cluster" = "shared"

  }
}


resource "aws_subnet" "PRI-EKS-MANAGED-SERVER-2C" {
  vpc_id                  = aws_vpc.this.id
  cidr_block              = cidrsubnet(var.vpc_cidr, 8, 4)
  availability_zone       = "ap-northeast-2c"
  map_public_ip_on_launch = false

  tags = {
    "Name"                              = "${var.vpc_prefix}-PRI-EKS-MANAGED-SERVER-2C"
    "kubernetes.io/role/internal-elb"   = "1"
    "kubernetes.io/cluster/${var.vpc_prefix}-Cluster" = "shared"

  }
}

resource "aws_subnet" "PRI-ARGOCD-MANAGED-SERVER-2C" {
  vpc_id                  = aws_vpc.this.id
  cidr_block              = cidrsubnet(var.vpc_cidr, 8, 5)
  availability_zone       = "ap-northeast-2c"
  map_public_ip_on_launch = false

  tags = {
    "Name"                              = "${var.vpc_prefix}-PRI-ARGOCD-MANAGED-SERVER-2C"
    "kubernetes.io/role/internal-elb"   = "1"
    "kubernetes.io/cluster/${var.vpc_prefix}-Cluster" = "shared"

  }
}

resource "aws_subnet" "PRI-NODE-2A" {
  vpc_id                  = aws_vpc.this.id
  cidr_block              = cidrsubnet(var.vpc_cidr, 8, 10)
  availability_zone       = "ap-northeast-2a"
  map_public_ip_on_launch = false

  tags = {
    "Name"                              = "${var.vpc_prefix}-PRI-NODE-2A"
    "kubernetes.io/role/internal-elb"   = "1"
    "kubernetes.io/cluster/${var.vpc_prefix}-Cluster" = "owned"

  }
}

resource "aws_subnet" "PRI-NODE-2C" {
  vpc_id                  = aws_vpc.this.id
  cidr_block              = cidrsubnet(var.vpc_cidr, 8, 11)
  availability_zone       = "ap-northeast-2c"
  map_public_ip_on_launch = false

  tags = {
    "Name"                              = "${var.vpc_prefix}-PRI-NODE-2C"
    "kubernetes.io/role/internal-elb"   = "1"
    "kubernetes.io/cluster/${var.vpc_prefix}-Cluster" = "owned"

  }
}

resource "aws_subnet" "PRI-RDS-2A" {
  vpc_id                  = aws_vpc.this.id
  cidr_block              = cidrsubnet(var.vpc_cidr, 8, 20)
  availability_zone       = "ap-northeast-2a"
  map_public_ip_on_launch = false

  tags = {
    "Name"                              = "${var.vpc_prefix}-PRI-RDS-2A"
    "kubernetes.io/role/internal-elb"   = "1"
    "kubernetes.io/cluster/${var.vpc_prefix}-Cluster" = "shared"

  }
}

resource "aws_subnet" "PRI-RDS-2C" {
  vpc_id                  = aws_vpc.this.id
  cidr_block              = cidrsubnet(var.vpc_cidr, 8, 21)
  availability_zone       = "ap-northeast-2c"
  map_public_ip_on_launch = false

  tags = {
    "Name"                              = "${var.vpc_prefix}-PRI-RDS-2C"
    "kubernetes.io/role/internal-elb"   = "1"
    "kubernetes.io/cluster/${var.vpc_prefix}-Cluster" = "shared"

  }
}
