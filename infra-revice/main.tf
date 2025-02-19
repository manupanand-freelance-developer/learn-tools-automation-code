module "tool-infra" {
    for_each = var.tools
    source = "./infra"
    name = each.key
    instance_type=each.value["instance_type"]
    domain_name = var.domain_name
  
}