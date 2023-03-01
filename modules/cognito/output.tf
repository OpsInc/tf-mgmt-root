output "cognito_arn" {
  description = "Cognito endpoint id"
  value       = aws_cognito_user_pool.pool.arn
}
