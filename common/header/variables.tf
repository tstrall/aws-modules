variable "region" {
  type        = string
  description = "AWS region to use"
  default     = "us-east-1"
}

variable "component_name" {
  type        = string
  description = "Name of the component (e.g. 'serverless-site')"
}

variable "nickname" {
  type        = string
  description = "Nickname (e.g. 'strall-com')"
}

variable "iac_prefix" {
  type        = string
  default     = "/iac"
}
