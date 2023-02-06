env          = "sandbox"
project_name = "mgmt"

projects = [
  {
    name            = "mgmt"
    manage_dns_zone = true
    zone_name       = "nodestack.cloud"
    dns_records     = []
  }
]
