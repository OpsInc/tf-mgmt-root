env = "sandbox"

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

// On veut avoir 1 project mgmt avec plusiers apps: forms, absences, horraires
// DNS, cloudfront, s3, cognito, apigateway: on aura juste 1 de chaque par project
// sous cloudfront et apigateway on aura un /app* ---> /forms, /absences, /horraire
// donc il faut quand meme un map de apps mais juste pour les /
