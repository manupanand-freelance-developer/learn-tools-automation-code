resource "aws_instance" "tool" {
  
    ami=data.aws_ami.ami-data.image_id
    instance_type = var.instance_type
    
  tags = {
    Name=var.name
  }
}


resource "aws_route53_record" "record-public" {
  zone_id = data.aws_route53_zone.zone.zone_id
  name = "${each.key}.${var.domain_name}"
  type = "A"
  ttl  = 25
  records = [aws_instance.tool[each.key].public_ip]
  
}
resource "aws_route53_record" "record-internal" {
  zone_id = data.aws_route53_zone.zone.zone_id
  name = "${each.key}.internal.${var.domain_name}"
  type = "A"
  ttl  = 25
  records = [aws_instance.tool[each.key].private_ip]
}
terraform {
  backend "s3" {
    
  }
}