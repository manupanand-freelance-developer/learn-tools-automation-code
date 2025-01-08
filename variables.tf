variable "tools" {
  default = {
    github-runner={
        instance_type="t3.small"
        policy_name=[
            "AdministartorAccess"
        ]
    }
    vault={
        instance_type="t3.small"
        policy_name=[    ]
    }
  }
}
variable "hosted_zone_id" {
  default = "hosted zone id"
}