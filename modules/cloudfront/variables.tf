variable "acm_certs" {
  description = "ACM Certificat info"
  type        = any
}

variable "bucket_log" {
  description = "Bucket Access Log"
  type        = string
}

variable "buckets" {
  description = "Bucket list"
  type        = any
}

variable "common_tags" {
  description = "Tags per brands"
  type        = map(string)
}

variable "environment" {
  description = "Project environment"
  type        = string
}

variable "price_class" {
  description = "PriceClass for the Cloudfront distributions"
  type        = string
}

variable "project_name" {
  description = "Project name for ressource suffix"
  type        = string
}

variable "projects" {
  description = "Map of all projects with config"
  type = list(object({
    name            = string
    manage_dns_zone = bool
    zone_name       = string
    dns_records = list(object({
      type    = string
      name    = string
      records = string
    }))
  }))
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
