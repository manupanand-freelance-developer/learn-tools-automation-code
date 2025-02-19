module "tool-infra" {
    for_each = var.tools
    source = "./infra"
    name = each.key
    instance_type=each.value["instance_type"]
    domain_name = var.domain_name
    zone_id=data.aws_route53_zone.zone.zone_id
    ami_id = data.aws_ami.ami-data.id
    user_password = var.user_password
  
}
 
terraform {
  backend "s3" {

    region = "ap-south-1"
  }
}
