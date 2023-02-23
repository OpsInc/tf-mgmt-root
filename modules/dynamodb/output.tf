output "kms_key_arn" {
  value = aws_kms_key.create_kms_dynamodb.arn
}
