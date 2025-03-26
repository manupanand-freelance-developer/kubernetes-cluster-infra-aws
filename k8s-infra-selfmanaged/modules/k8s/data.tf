data "aws_subnets" "test" {
  filter {
    name   = "dev-kube-subnet"
    values = [data.aws_vpc.test.id]
    
  }
}

data "aws_vpc" "test" {
    cidr_block = "10.10.0.0/16"
  filter {
    name = "dev-vpc-private"
    values = []
  }
}

