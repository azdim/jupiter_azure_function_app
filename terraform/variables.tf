variable "environment" {
  type        = string
  description = "Select environment; production, (dev)elopment and testing"

  validation {
    condition     = contains(["dev", "test", "prod"], var.environment)
    error_message = "The environment value must be one off the valid environments tags: dev, test, prod."
  }
}
variable "application" {
  description = "Name of the application running within the function app"
  default     = ""
  type        = string
}

variable "function_name" {
  description = "Name of the function running within the function app"
  type        = string
}
