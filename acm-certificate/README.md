# ACM Certificate Module

This Terraform module provisions a DNS-validated ACM certificate in `us-east-1`, with automatic Route 53 validation for CloudFront.

It is designed to be used in conjunction with other infrastructure — typically CloudFront distributions that require a TLS certificate.

> ✅ This module assumes that your DNS is hosted in Route 53 and the corresponding hosted zone exists.

---

## Features

- Creates an ACM certificate in `us-east-1` for use with CloudFront
- Supports multiple subject alternative names (SANs)
- Automatically creates DNS validation records in Route 53
- Waits for certificate to be validated
- Passes the certificate ARN back to be used in CloudFront
- Can be reused by multiple components via standard input parameters

---

## Usage

```hcl
module "acm_certificate" {
  source = "git::https://github.com/tstrall/aws-modules.git//acm-certificate?ref=main"

  providers = {
    aws = aws.us_east_1
  }

  domain_name               = "example.com"
  subject_alternative_names = ["www.example.com", "cdn.example.com"]
  zone_id                   = data.aws_route53_zone.this.zone_id
  tags                      = {
    Project = "my-project"
    Env     = "prod"
  }
}
```

---

## Inputs

| Name                      | Type             | Description                                                        | Required |
|---------------------------|------------------|--------------------------------------------------------------------|----------|
| `domain_name`             | `string`         | The primary domain to issue the certificate for                    | ✅ Yes   |
| `subject_alternative_names` | `list(string)` | Optional list of alternate domain names (SANs)                     | ✅ Yes   |
| `zone_id`                 | `string`         | Route 53 zone ID where DNS validation records will be created      | ✅ Yes   |
| `tags`                    | `map(string)`    | Tags to apply to resources                                          | ✅ Yes   |

---

## Outputs

| Name              | Description                             |
|-------------------|-----------------------------------------|
| `certificate_arn` | The ARN of the validated ACM certificate |
| `zone_id`         | The Route 53 zone ID passed into the module |

---

## Notes

- The certificate is provisioned in `us-east-1` due to CloudFront requirements.
- The module uses Terraform's `for_each` to create DNS validation records per domain.
- You should ensure that Route 53 has full control of the domain in question.

---

## Example with Lookup

```hcl
data "aws_route53_zone" "this" {
  name = "example.com"
}

module "acm_certificate" {
  source = "git::https://github.com/tstrall/aws-modules.git//acm-certificate?ref=main"

  providers = {
    aws = aws.us_east_1
  }

  domain_name               = "example.com"
  subject_alternative_names = ["www.example.com"]
  zone_id                   = data.aws_route53_zone.this.zone_id
  tags                      = {
    Owner = "devops"
  }
}
```

---

## License

This module is open source, under the [Apache 2.0 License](https://www.apache.org/licenses/LICENSE-2.0).
