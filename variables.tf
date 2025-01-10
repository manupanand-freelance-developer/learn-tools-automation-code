variable "tools" {
  default = {
    github-runner={
        instance_type="t3.small"
        policy_name=[
            "AdministartorAccess"
        ]
        ports={}#ports to open
    }
    vault={
        instance_type="t3.small"
        policy_name=[    ]
        ports={
          vault=8200
        }
    }
  }
}
variable "hosted_zone_id" {
  default = "hosted zone id"
}