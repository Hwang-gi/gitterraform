resource "aws_eip" "EIP-01" {
  #domain = "vpc"
}

resource "aws_eip" "EIP-02" {
  #domain = "vpc"
}
resource "aws_nat_gateway" "NGW-01" {
  allocation_id = aws_eip.EIP-01.id
  subnet_id     = aws_subnet.PUB-BASTION-2A.id
  tags = {
    "Name" = "${var.vpc_prefix}-NGW-01"
  }

}

resource "aws_nat_gateway" "NGW-02" {
  allocation_id = aws_eip.EIP-02.id
  subnet_id     = aws_subnet.PUB-BASTION-2C.id
  tags = {
    "Name" = "${var.vpc_prefix}-NGW-02"
  }

}
