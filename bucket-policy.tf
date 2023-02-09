locals {
  bucket = module.s3_buckets.created_buckets["frontend-${local.domain_name}"]
}

resource "aws_s3_bucket_policy" "apply_OAC" {
  bucket = local.bucket.id
  policy = jsonencode(
    {
      Version = "2012-10-17",
      Id      = "PolicyForCloudFrontPrivateContent",
      Statement = [
        {
          Sid    = "AllowCloudFrontServicePrincipal",
          Effect = "Allow",
          Principal = {
            Service = sort([
              "apigateway.amazonaws.com",
              "cloudfront.amazonaws.com",
            ])
          },
          Action   = "s3:GetObject",
          Resource = "${local.bucket.arn}/*"
          Condition = {
            StringEquals = {
              "AWS:SourceArn" = module.cloudfront.cloudfront_distributions.arn
            }
          }
        }
      ]
    }
  )

  depends_on = [
    module.s3_buckets,
    module.s3_logging,
  ]
}
