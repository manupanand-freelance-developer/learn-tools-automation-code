module "tool-infra" {
    for_each = var.tools
    source = "./infra"
    name = each.key
    instance_type=each.value["instance_type"]
    domain_name = var.domain_name
    zone_id=data.aws_route53_zone.zone.zone_id
    ami_id = data.aws_ami.ami-data.id
    user_password = var.user_password
    ports= each.value["ports"]
  
}
 
terraform {
  backend "s3" {
    
    # leave empty comes from each env state-files
    bucket = "dev-ops-state-manupa"
    key    = "server/tools.tfstate"
    region = "ap-south-1"
  }
}