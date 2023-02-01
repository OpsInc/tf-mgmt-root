resource "aws_kms_key" "create_kms_s3" {
  description             = "KMS key for ${local.global.project_name} in ${var.env} for S3 buckets"
  deletion_window_in_days = 10
  enable_key_rotation     = true

  tags = local.common_tags
}

resource "aws_kms_alias" "create_alias_s3_key" {
  name          = "alias/${var.project_name}-${var.env}-s3"
  target_key_id = aws_kms_key.create_kms_s3.key_id
}
