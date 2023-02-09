env = "dev"

project = {
  name      = "mgmt"
  zone_name = "nodestack.cloud"
}

apps = [
  {
    name = "forms"
    dns_records = [
      {
        name    = "test1"
        records = "test1.recrod.com"
        type    = "CNAME"
      }
    ]
  }
]

s3 = ["frontend", "backup"]
