variable "tools" {
  default = {
    github-runner={
        instance_type="t3.small"
        policy_name= ["AdministratorAccess"]
        ports={}
        volume_size=20

    }
    vault={
        instance_type="t3.small"
        policy_name= []
        ports={
          vault=8200
        }
        volume_size=20
    }
    #  minikube={
    #     instance_type="t3.medium"
    #     policy_name= []
    #     ports={
    #       kube=8443
    #     }
    #     volume_size=30
    # }
     elk={
        instance_type="r7i.large"
        policy_name= []
        ports={
          nginx=80
          logstash=5044
        }
        volume_size=30
    }
  }
}
variable "domain_name" {
  default = "manupanand.online"
}
variable "user_name" {
  
}
variable "password"{

}