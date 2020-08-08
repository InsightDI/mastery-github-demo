variable "tenant_id" {
  type        = string
  description = "The tenant to which the Terraform configuration will be deployed"
  default     = "55a46e16-637a-4cfb-acaa-d89183887b16"
}

variable "subscription_id" {
  type        = string
  description = "The subscription to which the Terraform configuration will be deployed"
  default     = "acd2e298-d61f-4ed2-8b28-dc2f60d9f382"
}

variable "client_id" {
  type        = string
  description = "The service principal ObjectId used to deploy the Terraform configuration"
  default     = "e9933c22-daee-4e6e-b396-e89eb2feed93"
}

variable "client_secret" {
  type        = string
  description = "The service principal client secret used to deploy the Terraform configuration"
}

variable "environment" {
  description = "The environment to which the Terraform configuration will be deployed"
  default     = "dev"
}

variable "app_name" {
  description = "The application to which the Terraform configuration is beholden"
  default     = "mastery"
}

variable "region_primary" {
  description = "The primary region to which the Terraform configuration is deployed"
  default     = "eastus2"
}

variable "tags" {
  description = "The default tags to be applied to infrastructure"
  default     = {}
}