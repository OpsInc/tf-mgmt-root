env = "sbx"

project   = "mgmt"
zone_name = "nodestack.cloud"

apps = [
  {
    name        = "forms"
    dns_records = []
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
  hash_key = "id"
}

// On veut avoir 1 project mgmt avec plusiers apps: forms, absences, horraires
// DNS, cloudfront, s3, cognito, apigateway: on aura juste 1 de chaque par project
// sous cloudfront et apigateway on aura un /app* ---> /forms, /absences, /horraire
// donc il faut quand meme un map de apps mais juste pour les /
