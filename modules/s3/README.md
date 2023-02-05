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
| <a name="input_acl"></a> [acl](#input\_acl) | S3 bucket ACL resource | `string` | `"private"` | no |
| <a name="input_bucket_log"></a> [bucket\_log](#input\_bucket\_log) | The bucket name used to send logs to | `string` | `""` | no |
| <a name="input_buckets"></a> [buckets](#input\_buckets) | List of buckets to create | `list(string)` | n/a | yes |
| <a name="input_common_tags"></a> [common\_tags](#input\_common\_tags) | Tags per brands | `map(string)` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment to de deployed to | `string` | n/a | yes |
| <a name="input_kms_arn"></a> [kms\_arn](#input\_kms\_arn) | The KMS ARN to be used by the module for encryption | `string` | `""` | no |
| <a name="input_logged"></a> [logged](#input\_logged) | This enables the bucket to send logs to a logging bucket | `bool` | n/a | yes |
| <a name="input_project_name"></a> [project\_name](#input\_project\_name) | The name for the current project, it allows us to differentiate each deployed resources | `string` | n/a | yes |
## Outputs

| Name | Description |
|------|-------------|
| <a name="output_bucket_arn_list"></a> [bucket\_arn\_list](#output\_bucket\_arn\_list) | n/a |
## Resources

| Name | Type |
|------|------|
| [aws_s3_bucket.create_bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket_acl.bucket_acl](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_acl) | resource |
| [aws_s3_bucket_logging.log_buckets](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_logging) | resource |
| [aws_s3_bucket_public_access_block.block_public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_public_access_block) | resource |
| [aws_s3_bucket_server_side_encryption_configuration.sse](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_server_side_encryption_configuration) | resource |
| [aws_s3_bucket_versioning.s3_versioning](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_versioning) | resource |

## Caution

*This documentation is automatically generated with Terraform-docs and must be modified via its .terraform-docs.yml file*

For more information please go to [Terraform-docs](https://terraform-docs.io)
<!-- END_TF_DOCS -->