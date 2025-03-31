
# control-plane resource

resource "aws_instance" "instance_control_plane" {
    depends_on               = [ aws_security_group.kube_control_plane ,aws_iam_instance_profile.iam_instance_profile]
    
    instance_type            = var.instance_type
    ami                      = var.aws_ami_id
    subnet_id                = data.aws_subnet.kube_subnet.id   
    iam_instance_profile     = aws_iam_instance_profile.iam_instance_profile.name
    vpc_security_group_ids   = [aws_security_group.kube_control_plane.id] 

    #instance option
    instance_market_options {
      market_type            = "spot"
      spot_options {
        instance_interruption_behavior      = "stop"
        spot_instance_type                  ="persistent" 
      } 
    } 
    #volume
    root_block_device {
        volume_size           =var.volume_size 
    }  
    #user data commands
    user_data = base64encode(templatefile("${path.module}/control-plane.sh",{
        AWS_USER     = var.aws_user
        AWS_PASSWORD = var.aws_password
        role_name    = "control-plane"
     }))
    tags={
        Name="${var.name}-${var.env}-instance"
    }
  
}
# delay and check


# worker resource 
resource "aws_instance" "instance_worker_node_1" {
    depends_on               = [ aws_security_group.kube_worker ,aws_iam_instance_profile.iam_instance_profile]
    
    instance_type            = var.instance_type
    ami                      = var.aws_ami_id
    subnet_id                = data.aws_subnet.kube_subnet.id   
    iam_instance_profile     = aws_iam_instance_profile.iam_instance_profile.name
    vpc_security_group_ids   = [aws_security_group.kube_worker.id] 

    #instance option
    instance_market_options {
      market_type            = "spot"
      spot_options {
        instance_interruption_behavior      = "stop"
        spot_instance_type                  ="persistent" 
      } 
    } 
    #volume
    root_block_device {
        volume_size           =var.volume_size 
    }  
    #user data commands
    user_data = base64encode(templatefile("${path.module}/worker.sh",{
        AWS_USER     = var.aws_user
        AWS_PASSWORD = var.aws_password
        role_name    = "worker-node-1"
        remote_ip    = "123.128.168.12"
     }))
    tags={
        Name="${var.name}-${var.env}-instance"
    }
  
}