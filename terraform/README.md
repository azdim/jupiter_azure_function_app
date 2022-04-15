# Terraform Configuration

* This code should act as foundation to a function app deployment

<!-- BEGIN_TF_DOCS -->
## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.2.0 |

## Resources

| Name | Type |
|------|------|
| [azurerm_application_insights.app-insights](https://registry.terraform.io/providers/hashicorp/azurerm/3.2.0/docs/resources/application_insights) | resource |
| [azurerm_function_app_function.python](https://registry.terraform.io/providers/hashicorp/azurerm/3.2.0/docs/resources/function_app_function) | resource |
| [azurerm_linux_function_app.function_app](https://registry.terraform.io/providers/hashicorp/azurerm/3.2.0/docs/resources/linux_function_app) | resource |
| [azurerm_resource_group.function_app](https://registry.terraform.io/providers/hashicorp/azurerm/3.2.0/docs/resources/resource_group) | resource |
| [azurerm_service_plan.function_app](https://registry.terraform.io/providers/hashicorp/azurerm/3.2.0/docs/resources/service_plan) | resource |
| [azurerm_storage_account.function_app](https://registry.terraform.io/providers/hashicorp/azurerm/3.2.0/docs/resources/storage_account) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_application"></a> [application](#input\_application) | Name of the application running within the function app | `string` | `""` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Select environment; production, (dev)elopment and testing | `string` | n/a | yes |
| <a name="input_function_name"></a> [function\_name](#input\_function\_name) | Name of the function running within the function app | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_function_app_default_hostname"></a> [function\_app\_default\_hostname](#output\_function\_app\_default\_hostname) | Deployed function app hostname |
| <a name="output_function_app_name"></a> [function\_app\_name](#output\_function\_app\_name) | Name of function app |
<!-- END_TF_DOCS -->
