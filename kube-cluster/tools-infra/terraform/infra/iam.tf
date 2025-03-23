#create iam role

resource "aws_iam_role" "iam-role" {
#   count              =  var.create_iam_role ? 1 : 0 # create only if required
  name               =  "${var.name}-iam-role"
  assume_role_policy =  jsonencode({
    "Version": "2012-10-17",
	"Statement": [
		{
            Action = "sts:AssumeRole"
            Effect = "Allow"
            Principal ={
                Service= "ec2.amazonaws.com"
            } 
        },
	]

  })
  tags = {
    Name= "${var.name}-iam-role"
  }
}

# ec2 need iam instnce profile to attach the role 
resource "aws_iam_instance_profile" "iam-instnace-profile" {
    # count   = var.create_iam_role ? 1 : 0
    name    = "${var.name}-iam-instance-policy"
    role    = aws_iam_role.iam-role.name 
}
# attach other iam policies if needed
resource "aws_iam_policy_attachment" "iam-policy-attach" {
    count   =  length(var.policy_name) 
    name    = "${var.name}-iam-policy-attachment-${var.policy_name[count.index]}"
    roles = [aws_iam_role.iam-role.name]
    policy_arn = "arn:aws:iam::aws:policy/${var.policy_name[count.index]}"
}