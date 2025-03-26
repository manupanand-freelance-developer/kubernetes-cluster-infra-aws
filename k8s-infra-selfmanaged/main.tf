module "kube" {
  source            = "./modules/k8s"
  env               = var.env
  vpc_name          = var.vpc["vpc_name"]
  subnet_name       = var.vpc["subnet_name"] 
}