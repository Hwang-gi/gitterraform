# BASTION SG
resource "aws_security_group" "SG_BASTION" {
  name        = "${var.vpc_prefix}-SG-BASTION"
  description = "Bastion Host Security Group"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    "Name" = "${var.vpc_prefix}-SG-BASTION"
  }
}

# EKS SG
resource "aws_security_group" "SG_EKS" {
  name   = "for EKS cluster"
  vpc_id = var.vpc_id

  ingress {
    from_port = 443
    to_port   = 443
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    "Name" = "${var.vpc_prefix}-SG-EKS-CLUSTER"
  }
}

# Worker Node SG
resource "aws_security_group" "SG_NODE" {
  name        = "for EKS Node Group"
  description = "EKS worker nodes security group"
  vpc_id = var.vpc_id

  ingress {
    from_port = 443
    to_port   = 443
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 2379
    to_port   = 2380
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 10250
    to_port   = 10250
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 10256
    to_port   = 10256
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 30000
    to_port   = 32767
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }

  egress {
    from_port = 0
    to_port   = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.vpc_prefix}-SG-EKS-WORKER-NODE"
  }
}

# EKS Managed SG
resource "aws_security_group" "SG_EKS-MANAGED-SERVER" {
  name   = "Security group for EKS Managed instance"
  vpc_id = var.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    "Name" = "${var.vpc_prefix}-SG-EKS-MANAGED-SERVER"
  }
}

# EFS SG
resource "aws_security_group" "SG_EFS" {
  name   = "for EFS storage"
  vpc_id = var.vpc_id

  tags = {
    "Name" = "${var.vpc_prefix}-SG-EFS"
  }
}

# EFS Managed Server SG
resource "aws_security_group" "SG_EFS_MANAGED_SERVER" {
  name   = "Security group for EFS Managed EC2 instance"
  vpc_id = var.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 2049
    to_port     = 2049
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    "Name" = "${var.vpc_prefix}-SG-EFS-MANAGED-SERVER"
  }
}

# RDS SG
resource "aws_security_group" "SG_RDS" {
  name   = "Security group for RDS Storage"
  vpc_id = var.vpc_id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    "Name" = "${var.vpc_prefix}-SG-RDS"
  }
}

resource "aws_security_group" "SG_ARGOCD" {
  name        = "argocd-security-group"
  description = "Security group for ArgoCD EC2 instance"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 6443
    to_port     = 6443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


# Redis SG
resource "aws_security_group" "SG_REDIS" {
  name   = "for Redis"
  vpc_id = var.vpc_id

  ingress {
    from_port   = 6379
    to_port     = 6379
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    "Name" = "${var.vpc_prefix}-SG-REDIS"
  }
}
