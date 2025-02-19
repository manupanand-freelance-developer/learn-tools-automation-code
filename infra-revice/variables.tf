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
