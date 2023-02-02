<!-- BEGIN_TF_DOCS -->
## Module Release Latest Version
| Version |
|:-------:|
| v.0.0.7  |


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
| <a name="module_dns"></a> [dns](#module\_dns) | ./modules/route53 | n/a |
| <a name="module_s3_buckets"></a> [s3\_buckets](#module\_s3\_buckets) | ./modules/s3 | n/a |
| <a name="module_s3_logging"></a> [s3\_logging](#module\_s3\_logging) | ./modules/s3 | n/a |
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_env"></a> [env](#input\_env) | Environment to deploy to | `string` | n/a | yes |
| <a name="input_project_name"></a> [project\_name](#input\_project\_name) | The project name | `string` | n/a | yes |
| <a name="input_projects"></a> [projects](#input\_projects) | Map of all projects with config | <pre>list(object({<br>    name            = string<br>    manage_dns_zone = bool<br>    zone_name       = string<br>    dns_records = list(object({<br>      type    = string<br>      name    = string<br>      records = string<br>    }))<br>  }))</pre> | n/a | yes |
| <a name="input_s3"></a> [s3](#input\_s3) | Map of S3 configuration | <pre>map(object({<br>    name = list(string)<br>    acl  = string<br>  }))</pre> | n/a | yes |
## Outputs

No outputs.
## Resources

| Name | Type |
|------|------|
| [aws_kms_alias.create_alias_s3_key](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_alias) | resource |
| [aws_kms_key.create_kms_s3](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key) | resource |

## Caution

*This documentation is automatically generated with Terraform-docs and must be modified via its .terraform-docs.yml file*

For more information please go to [Terraform-docs](https://terraform-docs.io)
<!-- END_TF_DOCS -->