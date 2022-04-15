resource "azurerm_resource_group" "function_app" {
  tags     = local.default_tags
  name     = local.resource_group_name
  location = "UK South"
}

resource "azurerm_storage_account" "function_app" {
  tags                     = local.default_tags
  name                     = local.sa_name
  resource_group_name      = azurerm_resource_group.function_app.name
  location                 = azurerm_resource_group.function_app.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_service_plan" "function_app" {
  name                = local.service_plan_name
  location            = azurerm_resource_group.function_app.location
  resource_group_name = azurerm_resource_group.function_app.name
  os_type             = "Linux"
  sku_name            = "B1"
}

resource "azurerm_application_insights" "app-insights" {
  name                = "python-fa-app-insights"
  resource_group_name = azurerm_resource_group.function_app.name
  location            = azurerm_resource_group.function_app.location
  application_type    = "web"
}

resource "azurerm_linux_function_app" "function_app" {
  tags                       = local.default_tags
  name                       = local.func_name
  resource_group_name        = azurerm_resource_group.function_app.name
  location                   = azurerm_resource_group.function_app.location
  service_plan_id            = azurerm_service_plan.function_app.id
  storage_account_name       = azurerm_storage_account.function_app.name
  storage_account_access_key = azurerm_storage_account.function_app.primary_access_key
  app_settings = {
    https_only                            = true
    APPINSIGHTS_INSTRUMENTATIONKEY        = azurerm_application_insights.app-insights.instrumentation_key
    APPLICATIONINSIGHTS_CONNECTION_STRING = azurerm_application_insights.app-insights.connection_string
    FUNCTIONS_EXTENSION_VERSION           = "~3"
    FUNCTIONS_WORKER_RUNTIME              = "python"
    PROPERTY_FILE_PATH                    = "property"
    SCM_DO_BUILD_DURING_DEPLOYMENT        = false
    WEBSITE_RUN_FROM_PACKAGE              = 1
  }

  site_config {}
}

resource "azurerm_function_app_function" "python" {
  name            = local.func_name
  function_app_id = azurerm_linux_function_app.function_app.id
  language        = "Python"

  file {
    name    = "function_app.py"
    content = file("../function/function_app.py")
  }

  test_data = jsonencode({
    "name" = "Azure"
  })

  config_json = jsonencode({
    "scriptFile" : "__init__.py",
    "disabled" : false,
    "bindings" = [
      {
        "authLevel" = "function"
        "direction" = "in"
        "name"      = "req"
        "type"      = "httpTrigger"
      },
      {
        "direction" = "out"
        "name"      = "$return"
        "type"      = "http"
      },
    ]
  })
}
