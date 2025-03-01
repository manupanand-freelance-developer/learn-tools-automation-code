resource "aws_instance" "tool" {
  ami=data.aws_ami.aws-rhel-ami.image_id
  instance_type = var.instance_type
  vpc_security_group_ids = [aws_security_group.tool-sg.ids]
  iam_instance_profile = aws_iam_instance_profile.instance-profile.name

  # spot instance
  instance_market_options {
    market_type = "spot"
    spot_options {
      instance_interruption_behavior = "stop"
      spot_instance_type = "persistent"
    }
  }
  # volume
  root_block_device {
    volume_size = var.volume_size
  }
    # Pass a shell script as user_data to set the password
  user_data = <<-EOF
              #!/bin/bash
              # Set the password for the user "ec2-user" or any user you have
              echo "ec2-user:password@TEST123" | chpasswd
              # Optionally enable password authentication if it's disabled by default
              sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config
              systemctl restart sshd
              EOF
              
  tags={
    Name= var.name
  }
}

resource "aws_security_group" "tool-sg" {
  
  name= "${var.name}-sg"
  description = "${var.name}-sg"

  egress  {
    from_port= 0
    to_port = 0
    protocol = "-1"
    cidr_blocks= ["0.0.0.0/0"]
  }

  # iterate particular block
  ingress {
    from_port= 22
    to_port=22
    protocol="TCP"
    cidr_blocks= ["0.0.0.0/0"]
  }

  dynamic "ingress" {
    for_each = each.value.ports
    content {
      from_port= ingress.value
      to_port= ingress.value
      protocol= "TCP"
      cidr_blocks= ["0.0.0.0/0"]
      description = ingress.key
    }
  }
  tags = {
    Name="${var.name}-sg"
  }

}

#route 53
resource "aws_route53_record" "record-public" {
  
  zone_id = data.aws_route53_zone.zone.zone_id
  name    = "${each.key}.${var.domain_name}"
  type    = "A"
  ttl     = 25
  records = [aws_instance.tool[each.key].public_ip]
} 
resource "aws_route53_record" "record-internal" {
  
  zone_id = data.aws_route53_zone.zone.zone_id
  name    = "${each.key}.internal.${var.domain_name}"
  type    = "A"
  ttl     = 25
  records = [aws_instance.tool[each.key].private_ip]
}