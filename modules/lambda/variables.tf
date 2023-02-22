variable "apps" {
  description = "Map of all apps with their config"
  type        = any
}

variable "common_tags" {
  description = "Tags per brands"
  type        = map(string)
}

variable "dynamodb_kms_key_arn" {
  description = "DynamoDB KMS key arn"
  type        = string
}

variable "project_identifier" {
  description = "The project name with environment"
  type        = string
}
