module "kube" {
  source            = "./modules/k8s"
  env               = var.env
}