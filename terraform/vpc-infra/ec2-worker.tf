resource "aws_instance" "kube-ec2" {
  for_each = var.ec2-instance
  ami=""
  instance_type = "t3.medium"
  subnet_id = aws_subnet.public_subnet.id
  vpc_security_group_ids = [aws_security_group.subnet-sg.id]
  tags = {
    Name=each.key
  }
}
# resource "aws_instance" "kube-worker1" {
#   ami=""
#   instance_type = "t3.medium"
#   subnet_id = aws_subnet.public_subnet.id
#   vpc_security_group_ids = [aws_security_group.subnet-sg.id]
#   tags = {
#     Name="kube-worker1"
#   }
# }
# resource "aws_instance" "kube-worker2" {
#   ami=""
#   instance_type = "t3.medium"
#   subnet_id = aws_subnet.public_subnet.id
#   vpc_security_group_ids = [aws_security_group.subnet-sg.id]
#   tags = {
#     Name="kube-worker2"
#   }
# }