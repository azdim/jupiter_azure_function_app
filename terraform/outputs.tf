output "function_app_name" {
  value       = azurerm_linux_function_app.function_app.name
  description = "Name of function app"
}

output "function_app_default_hostname" {
  value       = azurerm_linux_function_app.function_app.default_hostname
  description = "Deployed function app hostname"
}
