resource "aws_iam_role" "role" {
  name="${var.name}-role"
  assume_role_policy=jsondecode({
     Version="20212-10-17"
     Statement=[
        {
            Action = "sts:AssumeRole"
            Effect = "Allow"
            
            Principal ={
                Service ="ec2.amazonaws.com"
            }
        }
     ]
  })
  

  tags={
    tag-key="${var.name}-role"
  }
}

# need policy -access
 resource "aws_iam_role_policy_attachment" "policy-attach" {
    count=length(var.policy_name)
    role=aws_iam_role.role.name
    policy_arn="arn:aws:iam::aws:pilocy/${var.policy_name[count.index]}"#copy policy arn
   
 }
 #instanc eprofile
 resource "aws_iam_instance_profile" "instance-profile" {
   name="${var.name}-role"
   role=aws_iam_role.role.name
 }
