variable "acm_certs" {
  description = "ACM Certificat info"
  type        = any
}

variable "bucket_log" {
  description = "Bucket Access Log"
  type        = any
}


variable "common_tags" {
  description = "Tags per brands"
  type        = map(string)
}

variable "domain_name" {
  description = "Domain name for project"
  type        = string
}

variable "environment" {
  description = "Project environment"
  type        = string
}

variable "origin_bucket" {
  description = "Bucket list"
  type        = any
}

variable "price_class" {
  description = "PriceClass for the Cloudfront distributions"
  type        = string
}

variable "project" {
  description = "Project name for ressource suffix"
  type        = map(string)
}

variable "route53_zones" {
  description = "Created zones object"
  type        = any
}

variable "web_acl_id" {
  description = "ARN of WAF ACL"
  type        = string
  default     = ""
}
