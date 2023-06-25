<!-- BEGIN_TF_DOCS -->
## Module Release Latest Version
| Version |
|:-------:|
| v1.0.0  |


## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.5.0 |
| <a name="provider_aws.ca-central-1"></a> [aws.ca-central-1](#provider\_aws.ca-central-1) | 5.5.0 |
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.1.6 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.20 |
## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_api_gw"></a> [api\_gw](#module\_api\_gw) | ./modules/api-gw | n/a |
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
| <a name="input_apps"></a> [apps](#input\_apps) | Map of all apps within the project with their config | <pre>list(object({<br>    name = string<br>  }))</pre> | n/a | yes |
| <a name="input_dynamoDB"></a> [dynamoDB](#input\_dynamoDB) | DynamoDB config | <pre>object({<br>    hash_key = string<br>  })</pre> | n/a | yes |
| <a name="input_env"></a> [env](#input\_env) | Environment to deploy to | `string` | n/a | yes |
| <a name="input_lambdas"></a> [lambdas](#input\_lambdas) | Map of all lambda within the projects with their config | <pre>list(object({<br>    name = string<br>  }))</pre> | n/a | yes |
| <a name="input_project"></a> [project](#input\_project) | The project name | `string` | n/a | yes |
| <a name="input_s3"></a> [s3](#input\_s3) | List of S3 | `list(string)` | n/a | yes |
| <a name="input_waf_rules"></a> [waf\_rules](#input\_waf\_rules) | List of WAF AWS Manged Rules | `list(string)` | n/a | yes |
| <a name="input_zone_name"></a> [zone\_name](#input\_zone\_name) | The project FQDN | `string` | n/a | yes |
## Outputs

No outputs.
## Resources

| Name | Type |
|------|------|
| [aws_kms_alias.kms_global_alias](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_alias) | resource |
| [aws_kms_key.kms_global](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key) | resource |
| [aws_kms_replica_key.kms_replica-ca-central-1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_replica_key) | resource |
| [aws_lambda_permission.allow_cognito](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_permission) | resource |
| [aws_s3_bucket_policy.apply_OAC](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_policy) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |

## Caution

*This documentation is automatically generated with Terraform-docs and must be modified via its .terraform-docs.yml file*

For more information please go to [Terraform-docs](https://terraform-docs.io)
<!-- END_TF_DOCS -->
