resource "aws_route_table" "kube-cluster-rt" {
  vpc_id = aws_vpc.main.id
   

   route {
    cidr_block="0.0.0.0/0"
    gateway_id = aws_internet_gateway.kube-cluster-ig.id
   }
   tags = {
     Name="kube-cluster-rt"
   }
}