variable "tools" {
  default = {
    github-runner={
        instance_type="t3.micro"
    }
    vault={
        instance_type="t3.micro"
    }
  }
}
variable "domain_name" {
  default = "manupanand.online"
}
variable "zone_id" {
  default = data.aws_route53_zone.zone.zone_id
}
variable "ami_id" {
  default = data.aws_ami.ami-data.ids
}