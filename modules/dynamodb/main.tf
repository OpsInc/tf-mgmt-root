########################################
###               KMS                ###
########################################
resource "aws_kms_key" "create_kms_dynamodb" {
  description             = "KMS key for ${var.project_identifier} for DynamoDB"
  deletion_window_in_days = 10
  enable_key_rotation     = true
  multi_region            = true

  tags = var.common_tags
}

resource "aws_kms_alias" "create_alias_dynamodb_key" {
  name          = "alias/${var.project_identifier}-dynamo"
  target_key_id = aws_kms_key.create_kms_dynamodb.key_id
}

resource "aws_kms_replica_key" "replica-ca-central-1" {
  provider = aws.ca-central-1

  description             = "Multi-Region replica key for ${var.project_identifier}"
  deletion_window_in_days = 7
  primary_key_arn         = aws_kms_key.create_kms_dynamodb.arn
}

########################################
###             DynamoDB             ###
########################################
resource "aws_dynamodb_table" "create_dynamodb_table" {
  name         = var.project_identifier
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = var.dynamoDB.hash_key

  stream_enabled   = true
  stream_view_type = "NEW_AND_OLD_IMAGES"

  point_in_time_recovery {
    enabled = true
  }

  replica {
    region_name = "ca-central-1"
    kms_key_arn = aws_kms_replica_key.replica-ca-central-1.arn
  }

  server_side_encryption {
    enabled     = true
    kms_key_arn = aws_kms_key.create_kms_dynamodb.arn
  }

  attribute {
    name = var.dynamoDB.hash_key
    type = "S"
  }

  tags = var.common_tags
}
