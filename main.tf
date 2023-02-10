locals {
  common_tags = {
    environment          = var.env
    managed_by_terraform = true
    project              = var.project.name
  }

  # apps = {
  #   for app in var.apps : var.env == "production" ? "${app.name}-${var.project.name}" : "${app.name}-${var.project.name}-${var.env}" => app
  # }

  apps = {
    for app in var.apps : app.name => app
  }

  domain_name = var.env == "production" ? "${var.project.name}.${var.project.zone_name}" : "${var.project.name}-${var.env}.${var.project.zone_name}"

  # bucket_logging_name = flatten([
  #   for s3 in ["access-log"] :
  #   [for key, app in local.apps : "${s3}-${key}"]
  # ])

  # buckets_list = flatten([
  #   for s3 in var.s3 :
  #   [for key, app in local.apps : "${s3}-${key}"]
  # ])
}

module "dns" {
  source = "./modules/route53"

  domain_name = local.domain_name
  apps        = local.apps

  environment = var.env
  project     = var.project

  common_tags = local.common_tags
}

module "s3_logging" {
  source = "./modules/s3"

  buckets = ["access-log-${local.domain_name}"]

  acl     = "private"
  kms_arn = ""
  logged  = false # This is the logging bucket

  environment = var.env
  common_tags = local.common_tags
}

module "s3_buckets" {
  source = "./modules/s3"

  buckets = [for s3 in var.s3 : "${s3}-${local.domain_name}"]

  acl        = "private"
  bucket_log = module.s3_logging.created_buckets["access-log-${local.domain_name}"]
  kms_arn    = ""
  logged     = true

  environment = var.env
  common_tags = local.common_tags
}

module "waf_cloudfront" {
  source = "./modules/waf"

  scope      = "CLOUDFRONT"
  bucket_log = module.s3_logging.created_buckets["access-log-${local.domain_name}"]
  project    = var.project
  waf_rules  = var.waf_rules

  common_tags = local.common_tags
}

module "cloudfront" {
  source = "./modules/cloudfront"

  origin_bucket = module.s3_buckets.created_buckets["frontend-${local.domain_name}"]
  bucket_log    = module.s3_logging.created_buckets["access-log-${local.domain_name}"]
  acm_certs     = module.dns.acm_certs
  route53_zones = module.dns.route53_zones
  web_acl_id    = module.waf_cloudfront.web_acl_arn


  domain_name = local.domain_name
  environment = var.env
  project     = var.project

  price_class = "PriceClass_100"

  common_tags = local.common_tags

  depends_on = [
    module.s3_buckets,
    module.s3_logging,
    module.dns,
    # module.waf_cloudfront,
  ]
}
