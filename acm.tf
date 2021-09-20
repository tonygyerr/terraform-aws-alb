resource "aws_acm_certificate" "cert" {
  private_key       = var.tls_pem_filename #data.template_file.ppk.rendered
  # certificate_body  = var.tls_ppk_filename #data.template_file.pem.rendered
  tags = merge(map("Name", "${var.app_name}-cert"), var.tags)
}

resource "aws_acm_certificate_validation" "cert" {
  certificate_arn         = aws_acm_certificate.cert.arn
  validation_record_fqdns = [aws_route53_record.this.fqdn] #[module.alb.route53_record_fqdn] #[data.aws_route53_zone.app.fqdn]
}