resource "aws_internet_gateway" "IGW" {
  vpc_id = aws_vpc.this.id
  tags = {
    "Name" = "${var.vpc_prefix}-IGW"
  }

}
