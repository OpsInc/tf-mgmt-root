locals {

  env = var.env == "production" ? "" : "-${var.env}"

  # Fetch each project from var.projects and create list of maps
  projects = {
    for project in var.projects : "${project.name}${local.env}" => project if project.manage_dns_zone == true
  }

  # 1st loop ---> Fetch each project from var.projects to create a list
  # 2nd loop ---> Fetch each record from dns_records
  #          ---> We also add new key:value by merging each record with it in order to have an identifier
  #          ---> This will let us know for each record to which project it belongs

  records = flatten([
    for project in var.projects : [
      for record in project.dns_records : merge(
        record,
        { project_name = "${project.name}${local.env}" },
        { project_zone = "${project.name}${local.env}.${project.zone_name}" }
      )
    ] if project.manage_dns_zone == true
  ])

  # Create a list of SANs per project
  # Using sort() to always have the SANs listed in the same order
  san_list_per_project = {
    for project in local.projects : "${project.name}${local.env}" => sort(concat(
      [for record in project.dns_records : "${record.name}.${project.name}${local.env}.${project.zone_name}"],
    ))
  }

  # 1st loop ---> Fetch each project from var.projects to create a list
  # 2nd loop ---> Fetch each cnames that were generated from aws_acm_certificate.cert for each project
  #          ---> Generate new fields for the DNS cert validation trough CNAME creation in each zone
  validation_cname = flatten([
    for project in local.projects : [
      for cname in aws_acm_certificate.cert["${project.name}${local.env}"].domain_validation_options : {
        fqdn    = cname.domain_name
        name    = cname.resource_record_name
        record  = cname.resource_record_value
        type    = cname.resource_record_type
        zone_id = aws_route53_zone.create_zones["${project.name}${local.env}"].id
      }
    ]
  ])
}

data "aws_route53_zone" "fetch_parent" {
  for_each = local.projects

  name = each.value.zone_name

  # name = trim(each.value.zone_name, "${each.value.name}.")
}

resource "aws_route53_zone" "create_zones" {
  for_each = local.projects

  # name = each.value.zone_name
  name = "${each.value.name}${local.env}.${each.value.zone_name}"

  tags = var.common_tags
}

resource "aws_route53_record" "create_zone_ns" {
  for_each = local.projects

  zone_id = data.aws_route53_zone.fetch_parent[each.key].zone_id
  name    = "${each.value.name}${local.env}.${each.value.zone_name}"
  type    = "NS"
  ttl     = "30"
  records = aws_route53_zone.create_zones[each.key].name_servers
}

resource "aws_route53_record" "create_records" {
  for_each = { for record in local.records : "${record.name}.${record.project_zone}-${record.type}" => record }

  name    = each.value.name
  records = [each.value.records]
  type    = each.value.type
  ttl     = "300"
  zone_id = aws_route53_zone.create_zones[each.value.project_name].id
}

resource "aws_acm_certificate" "cert" {
  for_each = local.san_list_per_project

  domain_name               = aws_route53_zone.create_zones[each.key].name
  subject_alternative_names = each.value

  validation_method = "DNS"

  tags = var.common_tags

  lifecycle {
    create_before_destroy = true
  }

  depends_on = [
    aws_route53_record.create_records,
  ]
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
  for_each = local.projects

  certificate_arn = aws_acm_certificate.cert["${each.value.name}${local.env}"].arn
}
