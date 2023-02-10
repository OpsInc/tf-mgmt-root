########################################
###              Locals              ###
########################################
locals {
  validation_cname = [
    for cname in aws_acm_certificate.cert.domain_validation_options : {
      fqdn    = cname.domain_name
      name    = cname.resource_record_name
      record  = cname.resource_record_value
      type    = cname.resource_record_type
      zone_id = aws_route53_zone.create_zones.id
    }
  ]
}

########################################
###             Route53              ###
########################################
data "aws_route53_zone" "fetch_parent" {
  name = var.zone_name
}

resource "aws_route53_zone" "create_zones" {
  name = var.domain_name

  tags = var.common_tags
}

resource "aws_route53_record" "create_zone_ns" {
  zone_id = data.aws_route53_zone.fetch_parent.zone_id
  name    = var.domain_name
  type    = "NS"
  ttl     = "30"
  records = aws_route53_zone.create_zones.name_servers
}

resource "aws_acm_certificate" "cert" {
  domain_name       = aws_route53_zone.create_zones.name
  validation_method = "DNS"

  tags = var.common_tags

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_route53_record" "create_cert_validation_CNAME" {
  for_each = { for cname in local.validation_cname : cname.fqdn => cname }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = each.value.zone_id
}

resource "aws_acm_certificate_validation" "validate" {
  certificate_arn = aws_acm_certificate.cert.arn
}
