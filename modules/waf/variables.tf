variable "bucket_log" {
  description = "Bucket Access Log"
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

variable "scope" {
  description = "Specifies whether this is for an AWS CloudFront distribution or for a regional application. Valid values are CLOUDFRONT or REGIONAL"
  type        = string

  validation {
    condition = contains([
      "CLOUDFRONT",
      "REGIONAL",
    ], var.scope)
    error_message = "Must either CLOUDFRONT|REGIONAL"
  }
}

variable "waf_rules" {
  description = "List of WAF AWS Manged Rules"
  type        = list(string)
}
