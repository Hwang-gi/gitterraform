resource "aws_route_table" "RT-PUB" {
  vpc_id = aws_vpc.this.id

  tags = {
    "Name" = "${var.vpc_prefix}-RT-PUB"
  }

}

resource "aws_route_table" "RT-PRI-01" {
  vpc_id = aws_vpc.this.id
  tags = {
    "Name" = "${var.vpc_prefix}-RT-PRI-01"
  }
}

resource "aws_route_table" "RT-PRI-02" {
  vpc_id = aws_vpc.this.id

  tags = {
    "Name" = "${var.vpc_prefix}-RT-PRI-02"
  }

}
