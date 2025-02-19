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
variable "user_password" {
  description="Password for server"
  type  = string
  sensitive= true #keeps hiden from logs

}