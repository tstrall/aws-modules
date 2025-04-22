# common/header

A shared Terraform module for Adage components.

This module centralizes configuration loading and common variable handling for infrastructure components such as `serverless-site`, `route53-zone`, and others. It provides a consistent way to load configuration from SSM Parameter Store and apply standard tagging and naming conventions.

## What It Does

- Loads component-specific configuration from AWS Systems Manager Parameter Store
- Desensitizes values for compatibility with `for_each`, `count`, and conditionals
- Exposes standard fields like `tags`, `config_path`, and `runtime_path`
- Intended for use with Terragrunt-based workflows

## Inputs

| Name            | Description                                                        | Type   | Default       |
|-----------------|--------------------------------------------------------------------|--------|---------------|
| `region`        | AWS region used by the component                                   | string | `"us-east-1"` |
| `component_name`| Name of the component (e.g. `serverless-site`)                     | string | required       |
| `nickname`      | Logical instance name (e.g. `example-com`)                          | string | required       |
| `iac_prefix`    | SSM path prefix used for config and runtime resolution. Defaults to `/iac`, but may be overridden for compatibility with other environments or legacy paths. | string | `"/iac"`      |

## Outputs

| Name           | Description                                      |
|----------------|--------------------------------------------------|
| `config`       | Desensitized config object parsed from SSM       |
| `tags`         | Tags from config, if present                     |
| `config_path`  | Full SSM path used to load the config            |
| `runtime_path` | Standardized SSM path for writing runtime output |

## Example Usage

```hcl
module "header" {
  source = "git::https://github.com/usekarma/aws-modules.git//common/header?ref=main"

  region         = var.region
  component_name = var.component_name
  nickname       = var.nickname
  iac_prefix     = var.iac_prefix
}

locals {
  config = module.header.config
  tags   = module.header.tags
}
```

## Design Notes

This module assumes that configuration values under `/iac/...` are Git-managed and not sensitive. Any secrets or runtime credentials should be managed separately under a different namespace (e.g. `/secrets/`, or `/env/secure/...`).

The `iac_prefix` input allows the caller to override the default path prefix if their configuration is stored under a different namespace (such as `/iac-config` or `/config`). This is useful when integrating with systems that use a different organizational layout or when migrating legacy setups into Adage.

This module is intended for use in Adage-aligned infrastructure components where inputs are controlled via a central config repository and resolved dynamically at deploy time.
