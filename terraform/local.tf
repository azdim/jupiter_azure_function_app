# Define names for resources being created

locals {
  suffix                    = format("%s-%s", var.environment, var.application)
  resource_group_name       = format("rg-%s-001", local.suffix)
  sa_name                   = format("sa%s%s", var.environment, var.application)
  service_plan_name         = format("plan-%s", local.suffix)
  func_app_name             = format("func-%s", local.suffix)
  func_name                 = format("%s-%s", var.function_name, local.suffix)
  application_insights_name = format("api-%s", local.suffix)
  default_tags = tomap({

    "environment" = var.environment
    "applicaton"  = var.application
  })
}
