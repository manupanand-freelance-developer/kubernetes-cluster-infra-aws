# association map for all
resource "aws_route_table_association" "kube-cluster-rt-asso" {
  subnet_id = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.kube-cluster-rt.id
}