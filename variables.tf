variable "env" {
  description = "Environment to deploy to"
  type        = string
}

variable "project_name" {
  description = "The project name"
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
