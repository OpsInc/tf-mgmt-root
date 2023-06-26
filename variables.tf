variable "apps" {
  description = "Map of all apps within the project with their config"

  type = list(object({
    name = string
  }))
}

variable "lambdas" {
  description = "Map of all lambda within the projects with their config"

  type = list(object({
    name = string
  }))
}

variable "dynamoDB" {
  description = "DynamoDB config"

  type = object({
    hash_key = string
  })
}

variable "env" {
  description = "Environment to deploy to"
  type        = string
}

variable "project" {
  description = "The project name"
  type        = string
}

variable "s3" {
  description = "List of S3"
  type        = list(string)
}

variable "waf_rules" {
  description = "List of WAF AWS Manged Rules"
  type        = list(string)
}

variable "zone_name" {
  description = "The project FQDN"
  type        = string
}
