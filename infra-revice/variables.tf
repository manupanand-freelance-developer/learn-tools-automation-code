variable "tools" {
  default = {
    github-runner={
        instance_type="t3.micro"
        ports={}
    }
    vault={
        instance_type="t3.micro"
        ports={
          vault=8200
        }
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