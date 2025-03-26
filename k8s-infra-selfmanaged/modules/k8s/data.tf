data "aws_subnet" "test" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.test.id]
  }
  filter{
    name ="tag:Name"
    values = [var.subnet_name]
  }
}

data "aws_vpc" "test" {
    
  filter {
    name = "tag:Name"
    values = [var.vpc_name]
  }
}

