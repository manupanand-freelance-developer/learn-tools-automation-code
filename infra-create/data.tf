data "aws_ami" "rhel"{
    executable_users=["self"]
    most_recent=true
    name_regex="AMI name"
    owners = ["619494949"]#owner number
}