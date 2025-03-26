# resource "aws_security_group" "kube-control" {
  


# # TCP	Inbound	6443	    Kubernetes API server	    All
# # TCP	Inbound	2379-2380	etcd server client API	    kube-apiserver, etcd
# # TCP	Inbound	10250	    Kubelet API	                Self, Control plane
# # TCP	Inbound	10259	    kube-scheduler	            Self
# # TCP	Inbound	10257	    kube-controller-manager	    Self
# }

# resource "aws_security_group" "kube-worker" {

    
# # TCP	Inbound	10250	    Kubelet API	                Self, Control plane
# # TCP	Inbound	10256	    kube-proxy	                Self, Load balancers
# # TCP	Inbound	30000-32767	NodePort Services†	        All
# }