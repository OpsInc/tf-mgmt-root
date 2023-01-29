provider "aws" {
  region     = "us-east-1"
  access_key = var.access_key
  secret_key = var.secret_key

  # default_tags always prompt changes for ressrouce 'module.<S3_MODULE>.aws_s3_bucket.create_bucket'
  # A lot of issues on the aws provider
  #
  # default_tags {
  #   tags = local.common_tags
  # }
}

terraform {
  required_version = ">= 1.1.6"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.20"
    }
  }
  backend "s3" {
    region       = "us-east-1"
    session_name = "mgmt-terraform"
  }
}
