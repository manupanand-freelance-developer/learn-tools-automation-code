resource "aws_instance" "name" {
    ami=data.aws_ami.ami-data.image_id
    instance_type = "t3.micro"
    
  tags = {
    Name="test-server"
  }
}

terraform {
  backend "s3" {
    
  }
}