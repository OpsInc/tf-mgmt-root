<!-- BEGIN_TF_DOCS -->

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |
## Requirements

No requirements.
## Modules

No modules.
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_apps"></a> [apps](#input\_apps) | Map of all apps with their config | `any` | n/a | yes |
| <a name="input_common_tags"></a> [common\_tags](#input\_common\_tags) | Tags per brands | `map(string)` | n/a | yes |
| <a name="input_domain_name"></a> [domain\_name](#input\_domain\_name) | Domain name for project | `string` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment to de deployed to | `string` | n/a | yes |
| <a name="input_zone_name"></a> [zone\_name](#input\_zone\_name) | The project FQDN | `string` | n/a | yes |
## Outputs

| Name | Description |
|------|-------------|
| <a name="output_acm_certs"></a> [acm\_certs](#output\_acm\_certs) | Export all created ACM Certificats |
| <a name="output_route53_zones"></a> [route53\_zones](#output\_route53\_zones) | Export all created Hosted Zones |
## Resources

| Name | Type |
|------|------|
| [aws_acm_certificate.cert](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/acm_certificate) | resource |
| [aws_acm_certificate_validation.validate](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/acm_certificate_validation) | resource |
| [aws_route53_record.create_cert_validation_CNAME](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_route53_record.create_zone_ns](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_route53_zone.create_zones](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_zone) | resource |
| [aws_route53_zone.fetch_parent](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/route53_zone) | data source |

## Caution

*This documentation is automatically generated with Terraform-docs and must be modified via its .terraform-docs.yml file*

For more information please go to [Terraform-docs](https://terraform-docs.io)
<!-- END_TF_DOCS -->