variable "acl" {
  description = "S3 bucket ACL resource"
  type        = string

  default = "private"

  validation {
    condition = contains([
      "private",
      "public",
    ], var.acl)
    error_message = "Valid ACL value: private|public"
  }
}

variable "bucket_log" {
  description = "The bucket name used to send logs to"
  type        = string
  default     = ""
}

variable "buckets" {
  description = "List of buckets to create"
  type        = list(string)
}

variable "common_tags" {
  description = "Tags per brands"
  type        = map(string)
}

variable "environment" {
  description = "Environment to de deployed to"
  type        = string
}

variable "kms_arn" {
  description = "The KMS ARN to be used by the module for encryption"
  type        = string
  default     = ""
}

variable "logged" {
  description = "This enables the bucket to send logs to a logging bucket"
  type        = bool
}
