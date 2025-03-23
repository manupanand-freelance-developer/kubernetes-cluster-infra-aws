resource "aws_subnet" "public_subnet" {
  vpc_id = aws_vpc.main.id
  cidr_block = "10.0.2.0/24"# taken 256ips
  availability_zone = "ap-south-2"
  map_public_ip_on_launch =  true 

  tags = {
    Name= "10.0.2.0-ap-south-2-kube-cluster"
  }
}