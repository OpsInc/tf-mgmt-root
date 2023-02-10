########################################
###            CloudFront            ###
########################################
resource "aws_cloudfront_origin_access_control" "create_OAC" {
  name                              = "access-control-${var.domain_name}"
  description                       = "S3 Policy for Project ${var.domain_name}"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}

resource "aws_cloudfront_distribution" "s3_distribution" {
  enabled             = true
  is_ipv6_enabled     = true
  comment             = upper(var.domain_name)
  default_root_object = "index.html"
  price_class         = var.price_class
  aliases             = [var.domain_name]

  tags = var.common_tags

  logging_config {
    include_cookies = false
    bucket          = var.bucket_log.bucket_domain_name
    prefix          = var.domain_name
  }

  origin {
    domain_name = var.origin_bucket.bucket_regional_domain_name
    origin_id   = var.origin_bucket.id

    origin_access_control_id = aws_cloudfront_origin_access_control.create_OAC.id
  }

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = var.origin_bucket.id

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
      locations        = []
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = false
    acm_certificate_arn            = var.acm_certs.arn
    ssl_support_method             = "sni-only"
    minimum_protocol_version       = "TLSv1.2_2021"
  }

  web_acl_id = var.web_acl_id
}

resource "aws_route53_record" "create_cf_A_record" {
  zone_id = var.route53_zones.id
  name    = var.route53_zones.name
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.s3_distribution.domain_name
    zone_id                = aws_cloudfront_distribution.s3_distribution.hosted_zone_id
    evaluate_target_health = false
  }
}
