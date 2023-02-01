provider "aws" {
  region = "us-east-1"
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
