resource "aws_route_table_association" "RT-ASSOCIATE-PUB-BASTION-2A" {
  subnet_id      = aws_subnet.PUB-BASTION-2A.id
  route_table_id = aws_route_table.RT-PUB.id
}

resource "aws_route_table_association" "RT-ASSOCIATE-PUB-BASTION-2C" {
  subnet_id      = aws_subnet.PUB-BASTION-2C.id
  route_table_id = aws_route_table.RT-PUB.id
}

resource "aws_route_table_association" "RT-ASSOCIATE-PRI-EKS-MANAGED-SERVER-2A" {
  subnet_id      = aws_subnet.PRI-EKS-MANAGED-SERVER-2A.id
  route_table_id = aws_route_table.RT-PRI-01.id
}

resource "aws_route_table_association" "RT-ASSOCIATE-PRI-EFS-MANAGED-SERVER-2A" {
  subnet_id      = aws_subnet.PRI-EFS-MANAGED-SERVER-2A.id
  route_table_id = aws_route_table.RT-PRI-01.id
}

resource "aws_route_table_association" "RT-ASSOCIATE-PRI-01-2A" {
  subnet_id      = aws_subnet.PRI-NODE-2A.id
  route_table_id = aws_route_table.RT-PRI-01.id
}

resource "aws_route_table_association" "RT-ASSOCIATE-PRI-01-2C" {
  subnet_id      = aws_subnet.PRI-NODE-2C.id
  route_table_id = aws_route_table.RT-PRI-02.id
}

resource "aws_route_table_association" "RT-ASSOCIATE-PRI-02-2A" {
  subnet_id      = aws_subnet.PRI-RDS-2A.id
  route_table_id = aws_route_table.RT-PRI-01.id
}

resource "aws_route_table_association" "RT-ASSOCIATE-PRI-02-2C" {
  subnet_id      = aws_subnet.PRI-RDS-2C.id
  route_table_id = aws_route_table.RT-PRI-02.id
}

resource "aws_route_table_association" "RT-ASSOCIATE-ARGOCD-MANAGED-SERVER-2C" {
  subnet_id      = aws_subnet.PRI-ARGOCD-MANAGED-SERVER-2C.id
  route_table_id = aws_route_table.RT-PRI-02.id
}
