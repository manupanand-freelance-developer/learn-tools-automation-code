data "aws_ami" "aws-rhel-ami"{
    most_recent = true
    name_regex = "al2023-ami-2023.6.20250128.0-kernel-6.1-x86_64"
    owners = ["140264529686"]
}
data "aws_route53_zone" "zone"{
    name= var.domain_name
    
}