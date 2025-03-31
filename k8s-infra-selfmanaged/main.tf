module "control-plane" {
  source            = "./modules/control-plane"
  for_each          = var.control_plane
  env               = var.env
  vpc_name          = var.vpc["vpc_name"]
  subnet_name       = var.vpc["subnet_name"] 
  cp_ingress        = var.cp_ingress
  cp_egress         = var.cp_egress
  # worker_ingress    = var.worker_ingress #not needed
  # worker_egress     = var.worker_egress  #not needed
  name              = each.key
  instance_type     = each.value["instance_type"]
  policy_name       = each.value["policy_name"]
  volume_size       = each.value["volume_size"]
  aws_ami_id        = var.aws_ami_id
  aws_user          = var.aws_user 
  aws_password      = var.aws_password
  
}# depend on null and wait here

module "worker" {
  source            = "./modules/worker"
  for_each          = var.worker_instance
  env               = var.env
  vpc_name          = var.vpc["vpc_name"]
  subnet_name       = var.vpc["subnet_name"] 
  # cp_ingress        = var.cp_ingress #not needed
  # cp_egress         = var.cp_egress #not needed
  worker_ingress    = var.worker_ingress
  worker_egress     = var.worker_egress
  name              = each.key
  instance_type     = each.value["instance_type"]
  policy_name       = each.value["policy_name"]
  volume_size       = each.value["volume_size"]
  aws_ami_id        = var.aws_ami_id
  aws_user          = var.aws_user 
  aws_password      = var.aws_password
  remote_ip         = module.control-plane.aws_control_plane_private_ip 
  
}

# allow security groups to communicate 
# attach each port with security group

# resource "aws_vpc_security_group_ingress_rule" "control_plane_from_worker" {

  
 
#   from_port                     =  6443
#   to_port                       = 65535
#   ip_protocol                   = "TCP"
#   security_group_id             = aws_security_group.kube_worker.id# the initiater worker
#   referenced_security_group_id  = aws_security_group.kube_control_plane.id#destinaton security group control plane
# }
# resource "aws_vpc_security_group_ingress_rule" "worker_from_control_plane" {
 
#   from_port                     =  6443
#   to_port                       = 10260
#   ip_protocol                   = "TCP"
#   security_group_id             = aws_security_group.kube_control_plane.id# the initiater worker
#   referenced_security_group_id  = aws_security_group.kube_worker.id#destinaton security group control plane
# }