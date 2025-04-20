# aws-modules

Reusable Terraform modules for building dynamic AWS infrastructure.

This repository provides a growing library of standalone, versioned Terraform modules optimized for:

- AWS Organizations
- Parameter Store–driven configuration
- Terragrunt-based deployments
- Controlled runtime promotion and dynamic configuration resolution

Each module is designed to be:
- Self-contained and stateless
- Versioned and reusable across multiple environments
- Compatible with AWS-native best practices (e.g., DNS validation, IAM boundaries)
- Easy to plug into a Terragrunt-driven environment

## Modules

| Module           | Description                                               |
|------------------|-----------------------------------------------------------|
| [`acm-certificate`](./acm-certificate) | Provisions an ACM certificate in `us-east-1` and sets up DNS validation using Route 53. Designed for use with CloudFront custom domains. |

More modules will be added as shared patterns emerge.

## Example Usage

```hcl
module "acm_certificate" {
  source = "git::https://github.com/usekarma/aws-modules.git//acm-certificate?ref=v1.0.0"

  site_name      = "example.com"
  zone_name      = "example.com."
  domain_aliases = ["www.example.com"]
  tags = {
    Environment = "prod"
    Project     = "serverless-site"
  }
}
```

## Versioning

Each module follows Semantic Versioning. Use a Git tag like `?ref=v1.0.0` to pin to a stable version in production environments.

## Designed For

These modules are used in the `aws-iac` and `aws-config` ecosystem, which enables:

- Environment-aware, config-driven deployments
- Centralized parameter management via SSM
- Safe, modular infrastructure rollout across accounts

## Contributing

Contributions are welcome. Please open an issue or pull request if you'd like to improve an existing module or propose a new one.

## License

Licensed under the Apache License 2.0. See [LICENSE](./LICENSE) for details.
