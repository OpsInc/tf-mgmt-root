<!-- BEGIN_TF_DOCS -->

## Requirements

No requirements.
## Modules

No modules.
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_bucket_log"></a> [bucket\_log](#input\_bucket\_log) | Bucket Access Log | `any` | n/a | yes |
| <a name="input_common_tags"></a> [common\_tags](#input\_common\_tags) | Tags per brands | `map(string)` | n/a | yes |
| <a name="input_project_identifier"></a> [project\_identifier](#input\_project\_identifier) | The project name with environment | `string` | n/a | yes |
| <a name="input_scope"></a> [scope](#input\_scope) | Specifies whether this is for an AWS CloudFront distribution or for a regional application. Valid values are CLOUDFRONT or REGIONAL | `string` | n/a | yes |
| <a name="input_waf_rules"></a> [waf\_rules](#input\_waf\_rules) | List of WAF AWS Manged Rules | `list(string)` | n/a | yes |
## Outputs

| Name | Description |
|------|-------------|
| <a name="output_web_acl_arn"></a> [web\_acl\_arn](#output\_web\_acl\_arn) | n/a |
## Resources

| Name | Type |
|------|------|
| [aws_wafv2_web_acl.create_acl](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/wafv2_web_acl) | resource |

## Caution

*This documentation is automatically generated with Terraform-docs and must be modified via its .terraform-docs.yml file*

For more information please go to [Terraform-docs](https://terraform-docs.io)
<!-- END_TF_DOCS -->