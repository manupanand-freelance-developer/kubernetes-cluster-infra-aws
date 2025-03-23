resource "aws_security_group" "subnet-sg" {

    vpc_id = aws_vpc.main.id

    egress {
        from_port =  0
        to_port   =  0
        protocol  =  -1 
        cidr_blocks = ["0.0.0.0/0"]  
    }
    ingress {
        from_port = 22
        to_port   = 22
        protocol  = "TCP"
        cidr_blocks= ["0.0.0.0/0"]  
    }
    ingress {
        from_port =  80
        to_port   =  80
        protocol  =  "TCP" 
        cidr_blocks = ["0.0.0.0/0"]
    }
    #kubernetes 
     ingress {
        from_port =  6443
        to_port   =  6443
        protocol  =  "TCP" 
        cidr_blocks = ["0.0.0.0/0"]
    }
     ingress {
        from_port =  2379
        to_port   =  2379
        protocol  =  "TCP" 
        cidr_blocks = ["0.0.0.0/0"]
    }
    tags = {
      Name ="kube-cluster-subnet-sg"
    }
  
}