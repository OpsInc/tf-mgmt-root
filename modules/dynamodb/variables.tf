variable "dynamoDB" {
  description = "DynamoDB config"

  type = object({
    hash_key = string
  })
}

variable "common_tags" {
  description = "Tags per brands"
  type        = map(string)
}

variable "kms_global_arn" {
  description = "Global KMS key"
  type        = string
}

variable "kms_global_ca-central-1_arn" {
  description = "Global replica KMS key in ca-central-1"
  type        = string
}

variable "project_identifier" {
  description = "The project name with environment"
  type        = string
}
