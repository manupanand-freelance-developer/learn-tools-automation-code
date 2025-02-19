resource "aws_instance" "tool" {
  
    ami=var.ami_id
    instance_type = var.instance_type
    
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
