variable "apps" {
  description = "Map of all apps with their config"
  type        = map(any)
}

variable "cognito_arn" {
  description = "Congnito endpoint id"
  type        = string
}

variable "common_tags" {
  description = "Tags per brands"
  type        = map(string)
}

variable "kms_global_arn" {
  description = "Global KMS key"
  type        = string
}

variable "lambdas" {
  description = "Created Lambdas"
  type        = map(any)
}

variable "project_identifier" {
  description = "The project name with environment"
  type        = string
}
