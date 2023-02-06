data "aws_s3_bucket" "fetch_buckets" {
  for_each = local.projects

  bucket = each.key

  depends_on = [
    module.s3_buckets,
    module.s3_logging,
  ]
}

resource "aws_s3_bucket_policy" "apply_OAC" {
  for_each = local.projects

  bucket = data.aws_s3_bucket.fetch_buckets[each.key].id
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
          Resource = "${data.aws_s3_bucket.fetch_buckets[each.key].arn}/*"
          Condition = {
            StringEquals = {
              "AWS:SourceArn" = module.cloudfront.cloudfront_distributions[each.key].arn
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
