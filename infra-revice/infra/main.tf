resource "aws_instance" "tool" {
  
    ami=var.ami_id
    instance_type = var.instance_type
    vpc_security_group_ids = [aws_security_group.tools_security_group.id]
    iam_instance_profile = aws_iam_instance_profile.instance-profile.name
    #spot instance
    instance_market_options {
      market_type = "spot"
      spot_options {
        instance_interruption_behavior = "stop"
        spot_instance_type = "persistent"
      }
    }

  
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

resource "aws_security_group" "tools_security_group" {
  name="${var.name}-sg"
  description = "${var.name}-security-group"
  egress{
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks=["0.0.0.0/0"]
  }
  ingress{
      from_port = 22
      to_port   = 22
      protocol  = "TCP"
      cidr_blocks=["0.0.0.0/0"]
  }
  #iterate particular block
  dynamic "ingress" {
    for_each =var.ports
    content {
      from_port = ingress.value
      to_port = ingress.value
      protocol = "TCP"
      cidr_blocks = ["0.0.0.0/0"]
      description = "${var.name}-port-${ingress.key}"
    }
  }
  tags = {
    Name="${var.name}-sg"
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

