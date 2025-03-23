resource "aws_internet_gateway" "kube-cluster-ig" {
  vpc_id = aws_vpc.main.id 


  tags = {
    Name= "kube-cluster-ig"
  }
}