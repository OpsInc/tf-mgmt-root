variable "common_tags" {
  description = "Tags per brands"
  type        = map(string)
}

variable "domain_name" {
  description = "Domain name for project"
  type        = string
}

variable "lambda_post_confirmation_arn" {
  description = "ARN of the lambda that will be triggered after a User registers"
  type        = string
}

variable "project_identifier" {
  description = "The project name with environment"
  type        = string
}
