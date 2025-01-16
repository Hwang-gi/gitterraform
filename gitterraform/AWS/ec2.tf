resource "aws_instance" "bastion_2a" {
  ami = var.ubuntu_ami
  instance_type = var.micro_type
  subnet_id = aws_subnet.PUB-BASTION-2A.id
  vpc_security_group_ids = [aws_security_group.SG-BASTION.id]

  key_name = "tf-key-pair"

  tags = {
    Name = "${var.vpc_prefix}-BASTION-PUB-2A"
  }
}

resource "aws_instance" "bastion_2c" {
  ami = var.ubuntu_ami
  instance_type = var.micro_type
  subnet_id = aws_subnet.PUB-BASTION-2C.id
  vpc_security_group_ids = [aws_security_group.SG-BASTION.id]

  key_name = "tf-key-pair"

  tags = {
    Name = "${var.vpc_prefix}-BASTION-PUB-2C"
  }
}

resource "aws_instance" "eks_managed" {
  ami = var.ubuntu_ami
  instance_type = var.micro_type
  subnet_id = aws_subnet.PRI-EKS-MANAGED-SERVER-2A.id
  vpc_security_group_ids = [aws_security_group.SG-EKS-MANAGED-SERVER.id]

  key_name = "tf-key-pair"

  tags = {
    Name = "${var.vpc_prefix}-EKS-MANAGED-PRI-2A"
  }
}

resource "aws_instance" "efs_managed" {
  ami = var.ubuntu_ami
  instance_type = var.micro_type
  subnet_id = aws_subnet.PRI-EFS-MANAGED-SERVER-2A.id
  vpc_security_group_ids = [aws_security_group.SG-EFS-MANAGED-SERVER.id]

  key_name = "tf-key-pair"

  tags = {
    Name = "${var.vpc_prefix}-EFS-MANAGED-PRI-2A"
  }
}
