env = "dev"

project   = "mgmt"
zone_name = "nodestack.cloud"

apps = [
  {
    name = "forms"
  }
]

lambdas = [
  {
    name = "cognito-postauth"
  }
]

s3 = ["frontend", "backup", "lambda-source-code"]

waf_rules = [
  "AWSManagedRulesAmazonIpReputationList",
  "AWSManagedRulesCommonRuleSet",
  "AWSManagedRulesKnownBadInputsRuleSet",
  "AWSManagedRulesAnonymousIpList",
]

dynamoDB = {
  hash_key = "ID"
}
