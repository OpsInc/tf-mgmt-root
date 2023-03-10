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
    kms_key_arn = var.kms_global_ca-central-1_arn
  }

  server_side_encryption {
    enabled     = true
    kms_key_arn = var.kms_global_arn
  }

  attribute {
    name = var.dynamoDB.hash_key
    type = "S"
  }

  tags = var.common_tags
}
