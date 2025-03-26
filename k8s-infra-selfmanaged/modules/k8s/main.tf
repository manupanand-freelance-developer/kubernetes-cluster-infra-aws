
output "subnet" {
  value = data.aws_subnet.kube_subnet
}
# output "subnet_cidr_block" {
#   value = for s in data.aws_subnet.kube_subnet : s.cidr_block
# }