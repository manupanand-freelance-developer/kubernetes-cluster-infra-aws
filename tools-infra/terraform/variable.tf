variable "domain-name" {
  default = "manupanand.online"
}
variable "route53-zoneid" {
  default = "x"
}
variable "tools" {
  default = {
    workstation={
        instance_type="t4g.large"  #t4g.micro  t4g.xlarge(4/16) t4g.large(2/8)
        ports={https=443}
        policy_name=["AmazonEC2FullAccess","AmazonSSMFullAccess","CloudWatchAgentServerPolicy","AmazonS3ReadOnlyAccess","AmazonEC2ContainerRegistryFullAccess","AmazonVPCFullAccess"]
        volume_size= 25  
        create_dns= true 
        create_iam_role=true 
    }
    grunner_arm={
        instance_type="t4g.xlarge"  #c7g.xlarge(4/8)  t4g.xlarge(4/16)
        ports={https=443}
        policy_name=["AmazonEC2FullAccess","AmazonSSMFullAccess","AmazonEC2ContainerRegistryFullAccess","CloudWatchAgentServerPolicy","AmazonS3ReadOnlyAccess" ]
        volume_size= 25 
        create_dns= true 
        create_iam_role=true 
    }
    # grunner_x86={
    #     instance_type="c6i.xlarge"  #c6i.xlarge(4/8)   m6i.xlarge (4/16)
    #     ports={https=443}
    #     policy_name=["AmazonEC2FullAccess","AmazonSSMFullAccess","AmazonECRFullAccess","CloudWatchAgentServerPolicy","IAMPassRole","AmazonS3ReadOnlyAccess" ]
    #     volume_size= 25
    #     create_dns= true 
    #     create_iam_role=true 
    # }
    # test={
    #     instance_type="t4g.micro"  #c7g.medium(1/2) c7g.xlarge  t4g.xlarge  t4g.micro
    #     ports={https=443}
    #     policy_name=["AmazonEC2FullAccess","AmazonSSMFullAccess"]
    #     volume_size= 10  
    #     create_dns= true 
    #     create_iam_role=true 
    # }
    #   test_x86={
    #     instance_type="t3.small"  #intel
    #     ports={https=443}
    #     policy_name=["AmazonEC2FullAccess","AmazonSSMFullAccess"]
    #     volume_size= 10  
    #     create_dns= true 
    #     create_iam_role=true 
    # }
    # vault={
    #     instance_type=""
    #     ports={ vault= 8200}
    #     policy_name=[""]
    #     create_dns= true 
    #     volume_size=
    # }
    
    # jenkins={
    #     instance_type=""
    #     ports={}
    #     policy_name=[""]
    #     create_dns= true 
    #     volume_size=
    # }
    # argocd={
    #     instance_type=""
    #     ports={}
    #     policy_name=[""]
    #     create_dns= true 
    #     volume_size=
    # }
    # prometheus={
    #     instance_type=""
    #     ports={}
    #     policy_name=[""]
    #     create_dns= true 
    #     volume_size=
    # }
    # grafana={
    #     instance_type=""
    #     ports={}
    #     policy_name=[""]
    #     create_dns= true 
    #     volume_size=
    # }
    # sonarqube={
    #     instance_type=""
    #     ports={}
    #     policy_name=[""]
    #     create_dns= true 
    #     volume_size=
    # }
    # elk={
    #     instance_type=""
    #     ports={}
    #     policy_name=[""]
    #     create_dns= true 
    #     volume_size=
    # }


  }
}
variable "aws_user" {
  
}
variable "aws_password" {
  
}
variable "role_name" {
  
}