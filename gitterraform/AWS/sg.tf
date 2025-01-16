# BASTION SG
resource "aws_security_group" "SG-BASTION" {
  name        = "${var.vpc_prefix}-SG-BASTION"
  description = "for Bastion Server"
  vpc_id      = aws_vpc.this.id

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
resource "aws_security_group" "SG-EKS" {
  name   = "for EKS cluster"
  vpc_id = aws_vpc.this.id

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
resource "aws_security_group" "SG-NODE" {
  name        = "for EKS Node Group"
  description = "EKS worker nodes security group"
  vpc_id = aws_vpc.this.id

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
resource "aws_security_group" "SG-EKS-MANAGED-SERVER" {
  name   = "for EKS-managed server"
  vpc_id = aws_vpc.this.id

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
resource "aws_security_group" "SG-EFS" {
  name   = "for EFS storage"
  vpc_id = aws_vpc.this.id

  tags = {
    "Name" = "${var.vpc_prefix}-SG-EKS-MANAGED-SERVER"
  }
}

# EFS Managed Server SG
resource "aws_security_group" "SG-EFS-MANAGED-SERVER" {
  name   = "for EFS-managed server"
  vpc_id = aws_vpc.this.id

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
resource "aws_security_group" "SG-RDS" {
  name   = "for RDS"
  vpc_id = aws_vpc.this.id

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

# Redis SG
resource "aws_security_group" "SG-REDIS" {
  name   = "for Redis"
  vpc_id = aws_vpc.this.id

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
