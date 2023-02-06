output "acm_certs" {
  description = "Export all created ACM Certificats"
  value       = aws_acm_certificate.cert
}

output "route53_zones" {
  description = "Export all created Hosted Zones"
  value       = aws_route53_zone.create_zones
}
