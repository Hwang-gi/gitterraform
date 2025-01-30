resource "aws_vpc" "mainvpc" {
  cidr_block = "10.1.0.0/16"

  tags = {
    Name = "DEFAULT-VPC"
  }
}

# Create a new network ACL or use an existing one
resource "aws_network_acl" "main" {
  vpc_id = aws_vpc.mainvpc.id

  ingress {
    protocol   = -1
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  egress {
    protocol   = -1
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }
}

resource "aws_network_acl_association" "example" {
  network_acl_id = aws_network_acl.main.id
  subnet_id      = aws_subnet.example.id
}
