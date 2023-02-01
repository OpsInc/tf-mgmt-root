env          = "sandbox"
project_name = "mgmt"

projects = [
  {
    name            = "mgmt"
    manage_dns_zone = true
    zone_name       = "nodestack.cloud"
    dns_records     = []
  },
]

s3 = {
  s3_buckets = {
    name = ["forms"]
    acl  = "private"
  }
}
