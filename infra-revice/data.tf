data "aws_ami" "ami-data"{
    most_recent = true
    name_regex = "al2023-ami-2023.6.20250128.0-kernel-6.1-x86_64"
    owners = ["140264529686"]
}

# aws zone id
data "aws_route53_zone" "zone" {
  name=var.domain_name
}