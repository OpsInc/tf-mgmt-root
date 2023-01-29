locals {

  global = {
    environment = var.env
  }

  common_tags = {
    environment          = var.env
    managed_by_terraform = true
    terraform_project    = "Intact Digital Framework"
  }
}

module "wlf_dns" {
  source = "./modules/route53"
  # source = "git::https://githubifc.iad.ca.inet/lab-se/tf-module-wlf-route53.git?ref=v2.0.0"

  projects    = var.projects
  common_tags = local.common_tags # TODO add application_name from module to reference projects.each.name
}

output "fetch_parent" {
  value = module.wlf_dns.fetch_parent
}
