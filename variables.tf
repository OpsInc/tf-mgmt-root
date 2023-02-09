variable "env" {
  description = "Environment to deploy to"
  type        = string
}

variable "project" {
  description = "The project name"
  type        = map(string)
}

variable "apps" {
  description = "Map of all projects with config"
  type        = any
  # type = list(object({
  #   name            = string
  #   manage_dns_zone = bool
  #   zone_name       = string
  #   dns_records = list(object({
  #     type    = string
  #     name    = string
  #     records = string
  #   }))
  # }))
}

variable "s3" {
  description = "List of S3"
  type        = list(string)
}
