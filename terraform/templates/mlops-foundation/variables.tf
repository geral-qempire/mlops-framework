variable "project_name" {
  description = "Name of the MLOps project (used as prefix for all resources)"
  type        = string
}

variable "environment" {
  description = "Environment name (dev, qa, prd)"
  type        = string

  validation {
    condition     = contains(["dev", "qa", "prd"], var.environment)
    error_message = "Environment must be one of: dev, qa, prd."
  }
}

variable "location" {
  description = "Azure region for all resources"
  type        = string
}

variable "create_registry" {
  description = "Whether to create the shared Azure ML registry (should only be true for one environment)"
  type        = bool
  default     = false
}

variable "tags" {
  description = "Additional tags to apply to all resources"
  type        = map(string)
  default     = {}
}
