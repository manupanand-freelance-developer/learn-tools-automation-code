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