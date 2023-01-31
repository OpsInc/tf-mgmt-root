variable "access_key" {
  description = "AWS Access Key"
  type        = string

  default = ""
}
variable "secret_key" {
  description = "AWS Secret Key"
  type        = string

  default = ""
}

variable "env" {
  description = "Environment to be deployed to"
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
