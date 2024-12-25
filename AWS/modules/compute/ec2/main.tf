resource "aws_instance" "bastion" {
  count                       = length(aws_subnet.bastion)
  ami                         = var.ubuntu-ami
  instance_type               = "t2.micro"
  vpc_security_group_ids      = [aws_security_group.bastion_sg.id]
  subnet_id                   = element(aws_subnet.bastion, count.index)
  key_name                    = var.key_name
  associate_public_ip_address = true

  root_block_device {
    volume_size = "8"
    volume_type = "gp2"
    tags = {
      "Name" = "BASTION-VOLUME"
    }
  }

  tags = {
    "Name" = "${var.vpc_name}-PUB-BASTION-${element(aws_subnet.bastion, count.index)}"
  }
}

resource "aws_instance" "manage_eks" {
  ami                         = var.ubuntu-ami
  instance_type               = "t2.micro"
  vpc_security_group_ids      = [aws_security_group.manage_eks.id]
  subnet_id                   = aws_subnet.manage_eks.id
  key_name                    = var.key_name
  associate_public_ip_address = false

  root_block_device {
    volume_size = "8"
    volume_type = "gp2"
    tags = {
      "Name" = "EKS-MANAGED-VOLUME"
    }
  }

  tags = {
    "Name" = "${var.vpc_name}-PRI-EKS-MANAGED-2A"
  }
}

resource "aws_instance" "manage_eks" {
  ami                         = var.ubuntu-ami
  instance_type               = "t2.micro"
  vpc_security_group_ids      = [aws_security_group.manage_efs.id]
  subnet_id                   = aws_subnet.manage_efs.id
  key_name                    = var.key_name
  associate_public_ip_address = false

  root_block_device {
    volume_size = "8"
    volume_type = "gp2"
    tags = {
      "Name" = "EFS-MANAGED-VOLUME"
    }
  }

  tags = {
    "Name" = "${var.vpc_name}-PRI-EFS-MANAGED-2C"
  }
}
