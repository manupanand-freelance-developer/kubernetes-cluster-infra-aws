module "kube" {
  source            = "./modules/k8s"
  env               = var.env
  vpc_name          = var.vpc["vpc_name"]
  subnet_name       = var.vpc["subnet_name"] 
  cp_ingress        = var.cp_ingress
  cp_egress         = var.cp_egress
  worker_ingress    = var.worker_ingress
  worker_egress     = var.worker_egress
}
