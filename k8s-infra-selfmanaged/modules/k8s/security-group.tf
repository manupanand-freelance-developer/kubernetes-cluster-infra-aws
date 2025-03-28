resource "aws_security_group" "kube_control_plane" {
    description = "Security group for control plane"
    name        =  "${var.env}-kube-control-plane-sg"
    vpc_id      =   data.aws_vpc.private_vpc.id 
  

#ssh port
    ingress {
        from_port   = 22
        to_port     = 22
        protocol    = "TCP"
        cidr_blocks  =["0.0.0.0/0"] #cidr of default vpc
    }

# kube main ports
  dynamic "ingress" {
    for_each = var.cp_ingress
    content {
      from_port     = tonumber(split("-",ingress.value.port)[0])
      to_port       = tonumber(split("-",ingress.value.port)[length(split("-",ingress.value.port))-1])
      protocol      = "TCP"
      cidr_blocks   = [tostring(data.aws_subnet.kube_subnet.cidr_block) ]#var.kube_subnet_cidr data.aws_subnet.kube_subnet.cidr_block
    }
  }
# dynamic egress
    dynamic "egress" {
    for_each = var.cp_egress
    content {
        from_port   = tonumber(split("-",egress.value.port)[0])
        to_port     = tonumber(split("-",egress.value.port)[length(split("-",egress.value.port))-1])
        protocol    = "TCP"
        cidr_blocks = [tostring(data.aws_subnet.kube_subnet.cidr_block)] 
    }
    }


    tags={
        Name="${var.env}-kube-control-plane-sg"
    }
}
# TCP	Inbound	6443	    Kubernetes API server	    All
# TCP	Inbound	2379-2380	etcd server client API	    kube-apiserver, etcd
# TCP	Inbound	10250	    Kubelet API	                Self, Control plane
# TCP	Inbound	10259	    kube-scheduler	            Self
# TCP	Inbound	10257	    kube-controller-manager	    Self

resource "aws_security_group" "kube_worker" {
    description = "Security group for control plane"
    name        =  "${var.env}-kube-control-plane-sg"
    vpc_id      =   data.aws_vpc.private_vpc.id 
  

#ssh port
    ingress {
        from_port   = 22
        to_port     = 22
        protocol    = "TCP"
        cidr_blocks  =["0.0.0.0/0"] #cidr od fefault vpc
    }
    # ingress 
    dynamic "ingress" {
      for_each = var.worker_ingress
      content {
        from_port   = tonumber(split("-",ingress.value.port)[0])
        to_port     = tonumber(split("-",ingress.value.port)[length(split("-",ingress.value.port))-1])
        protocol    = "TCP"
        cidr_blocks = [tostring(data.aws_subnet.kube_subnet.cidr_block)] 
      }
    }
    #egress
    dynamic "egress" {
      for_each = var.worker_egress 
      content {
        from_port   =  tonumber(split("-",ingress.value.port)[0])
        to_port     = tonumber(split("-",ingress.value.port)[length(split("-",ingress.value.port))-1])
        protocol    = "TCP" 
        cidr_blocks = [tostring(data.aws_subnet.kube_subnet.cidr_block)] 
      }
    }

}
# TCP	Inbound	10250	    Kubelet API	                Self, Control plane
# TCP	Inbound	10256	    kube-proxy	                Self, Load balancers
# TCP	Inbound	30000-32767	NodePort Services†	        All