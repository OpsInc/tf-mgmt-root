#tfsec:ignore:aws-s3-enable-bucket-logging
resource "aws_s3_bucket" "create_bucket" {
  for_each = toset(var.buckets)

  bucket        = each.key
  force_destroy = var.environment == "sandbox" ? true : false

  tags = var.common_tags
}

resource "aws_s3_bucket_acl" "bucket_acl" {
  for_each = toset(var.buckets)

  bucket = aws_s3_bucket.create_bucket[each.key].id
  acl    = var.acl
}

resource "aws_s3_bucket_public_access_block" "block_public" {
  for_each = toset(var.buckets)

  bucket = aws_s3_bucket.create_bucket[each.key].id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_versioning" "s3_versioning" {
  for_each = toset(var.buckets)

  bucket = aws_s3_bucket.create_bucket[each.key].id

  versioning_configuration {
    status = "Enabled"
  }
}

# Cloudfront does not natively handles KMS, it needs to have a Lambda@Edge to decrypt/encrypt
#tfsec:ignore:aws-s3-encryption-customer-key
resource "aws_s3_bucket_server_side_encryption_configuration" "sse" {
  for_each = toset(var.buckets)

  bucket = aws_s3_bucket.create_bucket[each.key].id

  rule {
    bucket_key_enabled = false

    dynamic "apply_server_side_encryption_by_default" {
      for_each = var.kms_arn == "" ? toset([]) : toset(["kms"])

      content {
        kms_master_key_id = var.kms_arn
        sse_algorithm     = "aws:kms"
      }
    }

    dynamic "apply_server_side_encryption_by_default" {
      for_each = var.kms_arn == "" ? toset(["s3"]) : toset([])

      content {
        sse_algorithm = "AES256"
      }
    }
  }
}

resource "aws_s3_bucket_logging" "log_buckets" {
  for_each = var.logged == true ? toset(var.buckets) : toset([])

  bucket        = aws_s3_bucket.create_bucket[each.key].id
  target_bucket = var.bucket_log.id
  target_prefix = "s3_log/${each.key}"
}
