variable "env" {
  
}
variable "vpc_name" {
  
}
variable "subnet_name" {
  
}
variable "cp_ingress" {
  
}
variable "cp_egress" {
  
}
variable "kube_subnet_cidr" {
  default =  data.aws_subnet.kube_subnet.cidr_block
}