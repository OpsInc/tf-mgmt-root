resource "aws_wafv2_web_acl" "create_acl" {
  name        = "${var.project.name}-cloudfront-waf"
  description = "CloudFront WAF for ${var.project.name}"
  scope       = var.scope

  default_action {
    allow {}
  }

  dynamic "rule" {
    for_each = toset(var.waf_rules)

    content {
      name     = "AWS-${rule.key}"
      priority = index(var.waf_rules, rule.key)

      override_action {
        none {}
      }

      statement {
        managed_rule_group_statement {
          name        = rule.key
          vendor_name = "AWS"
        }
      }
      visibility_config {
        cloudwatch_metrics_enabled = true
        metric_name                = rule.key
        sampled_requests_enabled   = true
      }
    }
  }

  visibility_config {
    cloudwatch_metrics_enabled = true
    metric_name                = "${var.project.name}-cloudfront-waf"
    sampled_requests_enabled   = true
  }

  # Tag issues:
  # https://github.com/hashicorp/terraform-provider-aws/issues/23390
  # https://github.com/hashicorp/terraform-provider-aws/issues/19727
  # https://github.com/hashicorp/terraform-provider-aws/issues/23992
  tags = var.common_tags
}
