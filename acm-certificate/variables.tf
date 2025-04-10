variable "domain_name" {
  description = "Primary domain name for the certificate (e.g. strall.com)"
  type        = string
}

variable "subject_alternative_names" {
  description = "List of additional domains (e.g. www.strall.com)"
  type        = list(string)
  default     = []
}

variable "zone_id" {
  description = "Route 53 hosted zone ID to use for DNS validation"
  type        = string
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default     = {}
}
