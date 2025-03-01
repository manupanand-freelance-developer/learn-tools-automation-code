module "tool-infra-create" {
    for_each = var.tools
  source = "./infra-create"
  name = each.key
  instance_type=each.value["instance_type"]
  policy_name =  each.value["policy_name"]
  domain_name = var.domain_name
  ports = each.value["ports"]
  volume_size = each.value["volume_size"]
}
