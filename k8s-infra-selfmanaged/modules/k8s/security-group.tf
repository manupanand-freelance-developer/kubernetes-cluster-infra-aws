resource "aws_security_group" "kube_control_plane" {
    description = "Security group for control plane"
    name        =  "${var.env}-kube-control-plane-sg"
    vpc_id      =   data.aws_vpc.private_vpc.id 
  

#ssh port
ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "TCP"
    cidr_blocks  =["0.0.0.0/0"] 
}

# kube main ports
  dynamic "ingress" {
    for_each = var.cp_ingress
    content {
      from_port     = tonumber(split("-",ingress.value.port)[0])
      to_port       = tonumber(split("-",ingress.value.port)[length(split("-",ingress.value.port))-1])
      protocol      = "TCP"
      cidr_blocks   = ingress.value.cidr #var.kube_subnet_cidr
    }
  }
# TCP	Inbound	6443	    Kubernetes API server	    All
# TCP	Inbound	2379-2380	etcd server client API	    kube-apiserver, etcd
# TCP	Inbound	10250	    Kubelet API	                Self, Control plane
# TCP	Inbound	10259	    kube-scheduler	            Self
# TCP	Inbound	10257	    kube-controller-manager	    Self

        tags={
            Name="${var.env}-kube-control-plane-sg"
        }
}

# resource "aws_security_group" "kube_worker" {

    
# # TCP	Inbound	10250	    Kubelet API	                Self, Control plane
# # TCP	Inbound	10256	    kube-proxy	                Self, Load balancers
# # TCP	Inbound	30000-32767	NodePort Services†	        All
# }