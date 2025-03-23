#create aws instance
resource "aws_instance" "instance" {
  depends_on = [ aws_security_group.instance-sg, aws_iam_instance_profile.iam-instnace-profile ]
 
  instance_type             =  var.instance_type 
  ami                       =  var.ami_id
  iam_instance_profile      =  aws_iam_instance_profile.iam-instnace-profile.name
  vpc_security_group_ids    =  [aws_security_group.instance-sg.id]
  # instance option
  instance_market_options{
    market_type             = "spot"
    spot_options {
      instance_interruption_behavior = "stop"
      spot_instance_type    = "persistent"
    }

  }
  # provide  execution commads -user data
  user_data          = base64encode(templatefile("${path.module}/userdata.sh",{
    AWS_USER         = var.aws_user
    AWS_PASSWORD     = var.aws_password
    role_name        = var.name
  }))
  # volume root size
  root_block_device {
    volume_size = var.volume_size
  }
  tags={
    Name        ="${var.name}-server"
  }
}


# create security group
resource "aws_security_group" "instance-sg" {
  name = "${var.name}-sg"
#   vpc_id = 


  #outbound policy
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" 
    cidr_blocks =  ["0.0.0.0/0"]
  }
  # inbound policy
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "TCP" 
    cidr_blocks =  ["0.0.0.0/0"]
    
  }

#   #dynamic port allocation
    # dynamic "ingress" {
    #   for_each  =  each.value["ports"]
    #   content {
    #     from_port    = ingress.value
    #     to_port      = ingress.value 
    #     protocol     = "TCP"
    #     cidr_blocks  = ["0.0.0.0/0"]
    #     description  = ingress.key 
    #   }
      
    # }
}


 
# create route53
# public dns
 resource "aws_route53_record" "public-dns" {
    # count   = var.create_dns ? 1 : 0
    name    = "${var.name}.${var.domain-name}"
    type    = "A"
    ttl     = 25 
    records = [aws_instance.instance.public_ip]
    zone_id = data.aws_route53_zone.zone_id.id
  }
# private dns
 resource "aws_route53_record" "private-dns" {
    # count   = var.create_dns ? 1 : 0
    name    = "${var.name}.private.${var.domain-name}"
    type    = "A"
    ttl     = 25 
    records = [aws_instance.instance.private_ip]
    zone_id = data.aws_route53_zone.zone_id.id
  }
