data "aws_caller_identity" "current" {}

resource "aws_kms_key" "kms_global" {
  description             = "Multi-Region KMS key for ${local.project_identifier}"
  deletion_window_in_days = 10
  enable_key_rotation     = true
  multi_region            = true

  policy = jsonencode(
    {
      Version = "2012-10-17",
      Id      = "key-default-1",
      Statement = [
        {
          Sid    = "Enable IAM User Permissions",
          Effect = "Allow",
          Principal = {
            "AWS" = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
          },
          Action   = "kms:*",
          Resource = "*"
        },
        {
          Effect = "Allow",
          Principal = {
            Service = [
              "logs.us-east-1.amazonaws.com",
              "logs.ca-central-1.amazonaws.com",
            ]
          },
          Action = [
            "kms:Encrypt*",
            "kms:Decrypt*",
            "kms:ReEncrypt*",
            "kms:GenerateDataKey*",
            "kms:Describe*"
          ],
          Resource = "*",
          Condition = {
            ArnLike = {
              "kms:EncryptionContext:aws:logs:arn" : "arn:aws:logs:*:${data.aws_caller_identity.current.account_id}:*"
            }
          }
        }
      ]
    }
  )

  tags = local.common_tags
}

resource "aws_kms_alias" "kms_global_alias" {
  name          = "alias/${local.project_identifier}"
  target_key_id = aws_kms_key.kms_global.key_id
}

resource "aws_kms_replica_key" "kms_replica-ca-central-1" {
  provider = aws.ca-central-1

  description             = "Multi-Region replica key for ${local.project_identifier}"
  primary_key_arn         = aws_kms_key.kms_global.arn
  deletion_window_in_days = 7
}
