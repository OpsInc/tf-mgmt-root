env = "dev"

project   = "mgmt"
zone_name = "nodestack.cloud"

apps = [
  {
    name        = "forms"
    dns_records = []
  }
]

s3 = ["frontend", "backup"]

waf_rules = [
  "AWSManagedRulesAmazonIpReputationList",
  "AWSManagedRulesCommonRuleSet",
  "AWSManagedRulesKnownBadInputsRuleSet",
  "AWSManagedRulesAnonymousIpList",
]

dynamoDB = {
  hash_key = "id"
}
