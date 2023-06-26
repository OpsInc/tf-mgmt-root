<!-- BEGIN_TF_DOCS -->

## Requirements

No requirements.
## Modules

No modules.
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_acm_certs"></a> [acm\_certs](#input\_acm\_certs) | ACM Certificat info | `any` | n/a | yes |
| <a name="input_bucket_log"></a> [bucket\_log](#input\_bucket\_log) | Bucket Access Log | `any` | n/a | yes |
| <a name="input_common_tags"></a> [common\_tags](#input\_common\_tags) | Tags per brands | `map(string)` | n/a | yes |
| <a name="input_domain_name"></a> [domain\_name](#input\_domain\_name) | Domain name for project | `string` | n/a | yes |
| <a name="input_origin_bucket"></a> [origin\_bucket](#input\_origin\_bucket) | Bucket list | `any` | n/a | yes |
| <a name="input_price_class"></a> [price\_class](#input\_price\_class) | PriceClass for the Cloudfront distributions | `string` | n/a | yes |
| <a name="input_route53_zones"></a> [route53\_zones](#input\_route53\_zones) | Created zones object | `any` | n/a | yes |
| <a name="input_web_acl_id"></a> [web\_acl\_id](#input\_web\_acl\_id) | ARN of WAF ACL | `string` | n/a | yes |
## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cloudfront_distributions"></a> [cloudfront\_distributions](#output\_cloudfront\_distributions) | Export all created cloudfront distribution |
## Resources

| Name | Type |
|------|------|
| [aws_cloudfront_distribution.s3_distribution](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudfront_distribution) | resource |
| [aws_cloudfront_origin_access_control.create_OAC](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudfront_origin_access_control) | resource |
| [aws_route53_record.create_cf_A_record](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |

## Caution

*This documentation is automatically generated with Terraform-docs and must be modified via its .terraform-docs.yml file*

For more information please go to [Terraform-docs](https://terraform-docs.io)
<!-- END_TF_DOCS -->