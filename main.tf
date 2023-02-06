locals {
  common_tags = {
    environment          = var.env
    managed_by_terraform = true
    project              = var.project_name
  }

  # Create a list composed of only the name of each projects
  projects_list = [
    for project in var.projects : project.name
  ]

  # Fetch each project from var.projects and create list of maps
  projects = {
    for project in var.projects : "${project.name}-${var.env}" => project
  }
}

module "dns" {
  source = "./modules/route53"

  common_tags = local.common_tags
  environment = var.env
  projects    = var.projects
}

module "s3_logging" {
  source = "./modules/s3"

  buckets = ["mgmt-access-log"]

  acl = "private"
  # kms_arn = aws_kms_key.create_kms_s3.arn
  kms_arn = ""
  logged  = false # This is the logging bucket

  common_tags = local.common_tags
  environment = var.env
}

module "s3_buckets" {
  source = "./modules/s3"

  buckets = local.projects_list

  acl        = "private"
  bucket_log = module.s3_logging.created_buckets["mgmt-access-log"].id
  kms_arn    = ""
  logged     = true

  common_tags = local.common_tags
  environment = var.env
}

module "cloudfront" {
  source = "./modules/cloudfront"

  buckets       = module.s3_buckets.created_buckets
  bucket_log    = module.s3_logging.created_buckets["mgmt-access-log"].bucket_domain_name
  acm_certs     = module.dns.acm_certs
  route53_zones = module.dns.route53_zones
  # web_acl_id = module.waf_cloudfront.web_acl_arn

  projects    = var.projects
  environment = var.env

  common_tags  = local.common_tags
  project_name = var.project_name
  price_class  = "PriceClass_100"

  depends_on = [
    module.s3_buckets,
    module.s3_logging,
    module.dns,
    # module.waf_cloudfront,
  ]
}
