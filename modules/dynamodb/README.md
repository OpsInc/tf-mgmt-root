<!-- BEGIN_TF_DOCS -->

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 4.20 |
| <a name="provider_aws.ca-central-1"></a> [aws.ca-central-1](#provider\_aws.ca-central-1) | >= 4.20 |
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.20 |
## Modules

No modules.
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_common_tags"></a> [common\_tags](#input\_common\_tags) | Tags per brands | `map(string)` | n/a | yes |
| <a name="input_dynamoDB"></a> [dynamoDB](#input\_dynamoDB) | DynamoDB config | `any` | n/a | yes |
| <a name="input_project_identifier"></a> [project\_identifier](#input\_project\_identifier) | The project name with environment | `string` | n/a | yes |
## Outputs

No outputs.
## Resources

| Name | Type |
|------|------|
| [aws_dynamodb_table.create_dynamodb_table](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dynamodb_table) | resource |
| [aws_kms_alias.create_alias_dynamodb_key](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_alias) | resource |
| [aws_kms_key.create_kms_dynamodb](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key) | resource |
| [aws_kms_replica_key.replica-ca-central-1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_replica_key) | resource |

## Caution

*This documentation is automatically generated with Terraform-docs and must be modified via its .terraform-docs.yml file*

For more information please go to [Terraform-docs](https://terraform-docs.io)
<!-- END_TF_DOCS -->