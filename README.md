<!-- BEGIN_TF_DOCS -->
## Module Release Latest Version
| Version |
|:-------:|
| v.0.0.24  |


## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 4.20 |
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.1.6 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.20 |
## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_cloudfront"></a> [cloudfront](#module\_cloudfront) | ./modules/cloudfront | n/a |
| <a name="module_cognito"></a> [cognito](#module\_cognito) | ./modules/cognito | n/a |
| <a name="module_dns"></a> [dns](#module\_dns) | ./modules/route53 | n/a |
| <a name="module_dynamoDB"></a> [dynamoDB](#module\_dynamoDB) | ./modules/dynamodb | n/a |
| <a name="module_lambda"></a> [lambda](#module\_lambda) | ./modules/lambda | n/a |
| <a name="module_s3_buckets"></a> [s3\_buckets](#module\_s3\_buckets) | ./modules/s3 | n/a |
| <a name="module_s3_logging"></a> [s3\_logging](#module\_s3\_logging) | ./modules/s3 | n/a |
| <a name="module_waf_cloudfront"></a> [waf\_cloudfront](#module\_waf\_cloudfront) | ./modules/waf | n/a |
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_apps"></a> [apps](#input\_apps) | Map of all projects with config | `any` | n/a | yes |
| <a name="input_dynamoDB"></a> [dynamoDB](#input\_dynamoDB) | DynamoDB config | `any` | n/a | yes |
| <a name="input_env"></a> [env](#input\_env) | Environment to deploy to | `string` | n/a | yes |
| <a name="input_project"></a> [project](#input\_project) | The project name | `string` | n/a | yes |
| <a name="input_s3"></a> [s3](#input\_s3) | List of S3 | `list(string)` | n/a | yes |
| <a name="input_waf_rules"></a> [waf\_rules](#input\_waf\_rules) | List of WAF AWS Manged Rules | `list(string)` | n/a | yes |
| <a name="input_zone_name"></a> [zone\_name](#input\_zone\_name) | The project FQDN | `string` | n/a | yes |
## Outputs

No outputs.
## Resources

| Name | Type |
|------|------|
| [aws_s3_bucket_policy.apply_OAC](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_policy) | resource |

## Caution

*This documentation is automatically generated with Terraform-docs and must be modified via its .terraform-docs.yml file*

For more information please go to [Terraform-docs](https://terraform-docs.io)
<!-- END_TF_DOCS -->