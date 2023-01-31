variable "common_tags" {
  description = "Tags per brands"
  type        = map(string)
}

variable "env" {
  description = "Environment to de deployed to"
  type        = string
}

variable "projects" {
  description = "Map of all projects with config"
  type = list(object({
    name            = string
    manage_dns_zone = bool
    zone_name       = string
    dns_records = list(object({
      type    = string
      name    = string
      records = string
    }))
  }))
}
