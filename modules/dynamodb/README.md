<!-- BEGIN_TF_DOCS -->

## Requirements

No requirements.
## Modules

No modules.
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_common_tags"></a> [common\_tags](#input\_common\_tags) | Tags per brands | `map(string)` | n/a | yes |
| <a name="input_dynamoDB"></a> [dynamoDB](#input\_dynamoDB) | DynamoDB config | <pre>object({<br>    hash_key = string<br>  })</pre> | n/a | yes |
| <a name="input_kms_global_arn"></a> [kms\_global\_arn](#input\_kms\_global\_arn) | Global KMS key | `string` | n/a | yes |
| <a name="input_kms_global_ca-central-1_arn"></a> [kms\_global\_ca-central-1\_arn](#input\_kms\_global\_ca-central-1\_arn) | Global replica KMS key in ca-central-1 | `string` | n/a | yes |
| <a name="input_project_identifier"></a> [project\_identifier](#input\_project\_identifier) | The project name with environment | `string` | n/a | yes |
## Outputs

No outputs.
## Resources

| Name | Type |
|------|------|
| [aws_dynamodb_table.create_dynamodb_table](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dynamodb_table) | resource |

## Caution

*This documentation is automatically generated with Terraform-docs and must be modified via its .terraform-docs.yml file*

For more information please go to [Terraform-docs](https://terraform-docs.io)
<!-- END_TF_DOCS -->