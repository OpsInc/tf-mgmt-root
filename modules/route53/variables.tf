variable "apps" {
  description = "Map of all apps with their config"
  type        = any
}

variable "common_tags" {
  description = "Tags per brands"
  type        = map(string)
}

variable "environment" {
  description = "Environment to de deployed to"
  type        = string
}

variable "domain_name" {
  description = "Domain name for project"
  type        = string
}

variable "zone_name" {
  description = "The project FQDN"
  type        = string
}
