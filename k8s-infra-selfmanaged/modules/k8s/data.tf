data "aws_subnets" "test" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.test.id]
    
  }
}

data "aws_vpc" "test" {
    
  filter {
    name = "tag:Name"
    values = ["dev-vpc-private"]
  }
}

