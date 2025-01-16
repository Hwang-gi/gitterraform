resource "aws_route" "RT-PUB" {
  route_table_id         = aws_route_table.RT-PUB.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.IGW.id


}

resource "aws_route" "RT-PRI-01" {
  route_table_id         = aws_route_table.RT-PRI-01.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.NGW-01.id
}

resource "aws_route" "RT-PRI-02" {
  route_table_id         = aws_route_table.RT-PRI-02.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.NGW-02.id
}
