variable "common_tags" {
  description = "Tags per brands"
  type        = map(string)
}

variable "domain_name" {
  description = "Domain name for project"
  type        = string
}

variable "project_identifier" {
  description = "The project name with environment"
  type        = string
}
