module "kube" {
  source            = "./modules/k8s"
  for_each          = var.k8s_instance
  env               = var.env
  vpc_name          = var.vpc["vpc_name"]
  subnet_name       = var.vpc["subnet_name"] 
  cp_ingress        = var.cp_ingress
  cp_egress         = var.cp_egress
  worker_ingress    = var.worker_ingress
  worker_egress     = var.worker_egress
  name              = each.key
  instance_type     = each.value["instance_type"]
  policy_name       = each.value["policy_name"]
  volume_size       = each.value["volume_size"]
  aws_ami_id        = var.aws_ami_id
  aws_user          = var.aws_user 
  aws_password      = var.aws_password
  
}
