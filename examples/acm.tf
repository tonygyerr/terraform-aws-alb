

# resource "tls_private_key" "cert" {
#   algorithm = "RSA"
# }

# resource "tls_self_signed_cert" "example" {
#   key_algorithm   = "RSA"
#   private_key_pem = tls_private_key.cert.private_key_pem

#   subject {
#     common_name  = "example.com"
#     organization = "ACME Examples, Inc"
#   }

#   validity_period_hours = 12

#   allowed_uses = [
#     "key_encipherment",
#     "digital_signature",
#     "server_auth",
#   ]
# }

resource "aws_acm_certificate" "cert" {
  private_key       = data.template_file.ppk.rendered
  certificate_body  = data.template_file.pem.rendered
  tags = merge(map("Name", "${var.app_name}-cert"), var.tags)
}

# resource "aws_acm_certificate" "cert" {
#   private_key      = tls_private_key.cert.private_key_pem
#   certificate_body = tls_self_signed_cert.example.cert_pem
# }

# resource "aws_acm_certificate" "acm_certificate" {
#   domain_name       = tls_private_key.example.private_key_pem #var.route53_domain_name
#   validation_method = tls_self_signed_cert.example.cert_pem#var.validation_method 
  
#   lifecycle {
#     create_before_destroy = true
#   }
# }

resource "aws_acm_certificate_validation" "acm_certificate_validation" {
  certificate_arn         = aws_acm_certificate.cert.arn
  validation_record_fqdns = [module.alb.route53_record_fqdn] #[aws_route53_record.this.*.fqdn]
}    