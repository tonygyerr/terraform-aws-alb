resource "aws_acm_certificate" "cert" {
  private_key       = data.template_file.ppk.rendered #var.tls_pem_filename
  certificate_body  = data.template_file.pem.rendered #var.tls_ppk_filename
  tags = merge(map("Name", "${var.app_name}-cert"), var.tags)
}

# resource "aws_acm_certificate_validation" "cert" {
#   certificate_arn         = aws_acm_certificate.cert.arn
#   validation_record_fqdns = [for record in aws_route53_record.this : record.fqdn] #[aws_route53_record.this[each.key].fqdn] #[module.alb.route53_record_fqdn] #[data.aws_route53_zone.app.fqdn]
# }