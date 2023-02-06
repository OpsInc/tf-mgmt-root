output "created_buckets" {
  description = "Export all created buckets"
  value       = aws_s3_bucket.create_bucket
}
