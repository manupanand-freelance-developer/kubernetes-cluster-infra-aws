env="dev"
vpc={
   vpc_name     ="dev-vpc-private"
   subnet_name  ="dev-kube-subnet"
}
cp_ingress={
 
    api_server          =   {
                            port="6443"
                            cidr=["0.0.0.0/0"]#cidr of kube
                            }
    etcd                =   {
                            port="2379-2380"
                            cidr=["0.0.0.0/0"]#cidr of kube
                            }
    kubelet_api         =  {
                            port="10250"
                            cidr=["0.0.0.0/0"]#cidr of kube
                            }
    kube_scheduler      =  {
                            port="10259"
                            cidr=["0.0.0.0/0"]#cidr of kube
                            }
    kube_control_manager=  {
                            port="10257"
                            cidr=["0.0.0.0/0"]#cidr of kube
                            }

}
cp_egress={
    kubelet_api         =  {
                            port="10250"
                            cidr=["0.0.0.0/0"]#cidr of kube
                            }
    node_port           =  {
                            port="30000-32767"
                            cidr=["0.0.0.0/0"]#cidr of kube
                            }
}