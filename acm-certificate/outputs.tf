output "certificate_arn" {
  description = "ARN of the validated ACM certificate"
  value       = aws_acm_certificate_validation.cert.certificate_arn
}

output "validation_record_fqdns" {
  description = "List of FQDNs used for DNS validation"
  value       = [for record in aws_route53_record.cert_validation : record.fqdn]
}
