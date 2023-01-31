<!-- BEGIN_TF_DOCS -->
## Module Release Latest Version
| Version |
|:-------:|
| $VERSION  |


## Providers

No providers.
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.1.6 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.20 |
## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_wlf_dns"></a> [wlf\_dns](#module\_wlf\_dns) | ./modules/route53 | n/a |
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_access_key"></a> [access\_key](#input\_access\_key) | AWS Access Key | `string` | `""` | no |
| <a name="input_env"></a> [env](#input\_env) | Environment to be deployed to | `string` | n/a | yes |
| <a name="input_projects"></a> [projects](#input\_projects) | Map of all projects with config | <pre>list(object({<br>    name            = string<br>    manage_dns_zone = bool<br>    zone_name       = string<br>    dns_records = list(object({<br>      type    = string<br>      name    = string<br>      records = string<br>    }))<br>  }))</pre> | n/a | yes |
| <a name="input_secret_key"></a> [secret\_key](#input\_secret\_key) | AWS Secret Key | `string` | `""` | no |
## Outputs

| Name | Description |
|------|-------------|
| <a name="output_fetch_parent"></a> [fetch\_parent](#output\_fetch\_parent) | n/a |
## Resources

No resources.

## Caution

*This documentation is automatically generated with Terraform-docs and must be modified via its .terraform-docs.yml file*

For more information please go to [Terraform-docs](https://terraform-docs.io)
<!-- END_TF_DOCS -->