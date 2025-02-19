resource "aws_instance" "tool" {
  
    ami=var.ami_id
    instance_type = var.instance_type

  
     # Pass a shell script as user_data to set the password
  user_data = <<-EOF
              #!/bin/bash
              # Set the password for the user "ec2-user" or any user you have
              echo "ec2-user:${var.user_password}" | chpasswd
              # Optionally enable password authentication if it's disabled by default
              sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config
              systemctl restart sshd
              EOF
    
  tags = {
    Name=var.name
  }
}


resource "aws_route53_record" "record-public" {
 
  zone_id = var.zone_id
  name = "${var.name}.${var.domain_name}"
  type = "A"
  ttl  = 25
  records = [aws_instance.tool.public_ip]
  
}
resource "aws_route53_record" "record-internal" {
  zone_id = var.zone_id
  name = "${var.name}.internal.${var.domain_name}"
  type = "A"
  ttl  = 25
  records = [aws_instance.tool.private_ip]
}

