terraform {
  # Required for Terragrunt compatibility
  backend "s3" {}
}

# Default AWS provider
provider "aws" {
  region = var.region
}

# us-east-1 provider for CloudFront/ACM (optional)
provider "aws" {
  alias  = "us_east_1"
  region = "us-east-1"
}

data "aws_ssm_parameter" "config" {
  name = "${var.iac_prefix}/${var.component_name}/${var.nickname}/config"
}

locals {
  config = try(nonsensitive(jsondecode(data.aws_ssm_parameter.config.value)), {})
  tags   = try(local.config.tags, {})

  config_path  = data.aws_ssm_parameter.config.name
  runtime_path = "${var.iac_prefix}/${var.component_name}/${var.nickname}/runtime"
}
W