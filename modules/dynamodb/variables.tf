variable "dynamoDB" {
  description = "DynamoDB config"
  type        = any
}

variable "common_tags" {
  description = "Tags per brands"
  type        = map(string)
}

variable "project_identifier" {
  description = "The project name with environment"
  type        = string
}
