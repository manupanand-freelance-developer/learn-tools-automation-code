resource "aws_instance" "name" {
  for_each = var.tools
    ami=data.aws_ami.ami-data.image_id
    instance_type = "t3.micro"
    
  tags = {
    Name="${each.key}-server"
  }
}

terraform {
  backend "s3" {
    
  }
}