resource "aws_instance" "tool" {
  
    ami=var.ami_id
    instance_type = var.instance_type
    
  tags = {
    Name=var.name
  }
}


resource "aws_route53_record" "record-public" {
  zone_id = var.zone_id
  name = "${each.key}.${var.domain_name}"
  type = "A"
  ttl  = 25
  records = [aws_instance.tool[each.key].public_ip]
  
}
resource "aws_route53_record" "record-internal" {
  zone_id = var.zone_id
  name = "${each.key}.internal.${var.domain_name}"
  type = "A"
  ttl  = 25
  records = [aws_instance.tool[each.key].private_ip]
}
terraform {
  backend "s3" {
    
  }
}