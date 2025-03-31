module "security_groups" {
  source = "./modules/security-group"
  cp_ingress        = var.cp_ingress 
  cp_egress         = var.cp_egress 
  worker_ingress    = var.worker_ingress
  worker_egress     = var.worker_egress
  vpc_name          = var.vpc_name
  subnet_name       = var.subnet_name
}

module "control-plane" {
  source                   = "./modules/control-plane"
  for_each                 = var.control_plane
  env                      = var.env
  kube_subnet_id           = module.security_groups.kube_subnet_id
  name                     = each.key
  instance_type            = each.value["instance_type"]
  policy_name              = each.value["policy_name"]
  volume_size              = each.value["volume_size"]
  aws_ami_id               = var.aws_ami_id
  aws_user                 = var.aws_user 
  aws_password             = var.aws_password
  private_security_group_id= module.security_groups.control_plane_security_group
  
}# depend on null and wait here

module "worker" {
  source                    = "./modules/worker"
  for_each                  = var.worker_instance
  env                       = var.env
  kube_subnet_id            = module.security_groups.kube_subnet_id
  name                      = each.key
  instance_type             = each.value["instance_type"]
  policy_name               = each.value["policy_name"]
  volume_size               = each.value["volume_size"]
  aws_ami_id                = var.aws_ami_id
  aws_user                  = var.aws_user 
  aws_password              = var.aws_password
  remote_ip                 = module.control-plane["master_node_1"].aws_control_plane_private_ip 
  private_security_group_id = module.security_groups.worker_security_group
  
}

