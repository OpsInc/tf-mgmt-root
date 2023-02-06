output "cloudfront_distributions" {
  description = "Export all created cloudfront distribution"
  value       = aws_cloudfront_distribution.s3_distribution
}
