
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
    tags={
        Name="${var.name}-${var.env}-instance"
    }
  
}


# worker resource 
