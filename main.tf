locals {
  global = {
    environment  = var.env
    project_name = var.project_name
  }

  common_tags = {
    environment          = var.env
    managed_by_terraform = true
    project              = var.project_name
  }
}

module "dns" {
  source = "./modules/route53"

  common_tags = local.common_tags
  env         = var.env
  projects    = var.projects
}

module "s3_logging" {
  source = "./modules/s3"

  buckets = ["access-log"]

  acl     = "private"
  kms_arn = aws_kms_key.create_kms_s3.arn
  logged  = false # This is the logging bucket

  common_tags  = local.common_tags
  environment  = local.global.environment
  project_name = local.global.project_name
}

module "s3_buckets" {
  source = "./modules/s3"

  buckets = var.s3["s3_buckets"]["name"]

  acl        = "private"
  bucket_log = module.s3_logging.bucket_arn_list["access-log"].id
  kms_arn    = aws_kms_key.create_kms_s3.arn
  logged     = true

  common_tags  = local.common_tags
  environment  = local.global.environment
  project_name = local.global.project_name
}
