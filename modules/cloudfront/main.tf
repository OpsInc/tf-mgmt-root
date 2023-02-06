########################################
###              LOCALS              ###
########################################
locals {
  # Fetch each project from var.projects and create list of maps
  projects = {
    for project in var.projects : "${project.name}-${var.environment}" => project
  }
}

########################################
###            CloudFront            ###
########################################
resource "aws_cloudfront_origin_access_control" "create_OAC" {
  name                              = "access-control-${var.project_name}-${var.environment}"
  description                       = "S3 Policy for project ${var.project_name}-${var.environment}"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}

resource "aws_cloudfront_distribution" "s3_distribution" {
  for_each = local.projects

  enabled             = true
  is_ipv6_enabled     = true
  comment             = "${upper(each.key)} project"
  default_root_object = "index.html"
  price_class         = var.price_class
  aliases             = ["${each.key}.${each.value.zone_name}"]

  tags = var.common_tags

  logging_config {
    include_cookies = false
    bucket          = var.bucket_log
    prefix          = each.key
  }

  dynamic "origin" {
    for_each = var.buckets

    content {
      domain_name = origin.value.bucket_regional_domain_name
      origin_id   = origin.value.id

      origin_access_control_id = aws_cloudfront_origin_access_control.create_OAC.id
    }
  }

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = var.buckets[each.value.name].id

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
    acm_certificate_arn            = var.acm_certs[each.key].arn
    ssl_support_method             = "sni-only"
    minimum_protocol_version       = "TLSv1.2_2021"
  }

  custom_error_response {
    error_code            = 404
    error_caching_min_ttl = 10
    response_page_path    = "/"
    response_code         = 200
  }

  custom_error_response {
    error_code            = 403
    error_caching_min_ttl = 10
    response_page_path    = "/"
    response_code         = 200
  }

  # Waf will be added shorlty
  #tfsec:ignore:aws-cloudfront-enable-waf
  web_acl_id = var.web_acl_id
}

resource "aws_route53_record" "create_cf_A_record" {
  for_each = var.route53_zones

  zone_id = each.value.zone_id
  name    = each.value.name
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.s3_distribution[each.key].domain_name
    zone_id                = aws_cloudfront_distribution.s3_distribution[each.key].hosted_zone_id
    evaluate_target_health = false
  }
}
