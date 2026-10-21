variable "region" {
  description = "AWS region to deploy into."
  type        = string
  default     = "us-east-1"
}

variable "environment" {
  description = "Environment name used in resource names and tags."
  type        = string
  default     = "dev"

  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "environment must be one of: dev, staging, prod."
  }
}

variable "bucket_prefix" {
  description = "Prefix for the artifacts bucket name (lowercase letters, numbers, hyphens)."
  type        = string
  default     = "lab-artifacts"
}

variable "noncurrent_version_days" {
  description = "Days to keep old object versions before deleting them."
  type        = number
  default     = 30
}
