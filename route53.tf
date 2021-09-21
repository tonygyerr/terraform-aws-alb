resource "aws_route53_zone" "this" {
  # count = var.load_balancer_type == "application" ? 0 : 1
  name = var.route53_zone_name

  vpc {
    vpc_id = var.vpc_config.vpc_id #data.aws_vpc.computer_vision.id
  }
}

resource "aws_route53_record" "this" {
  # count      = var.load_balancer_type == "application" ? 0 : 1
  allow_overwrite = true
  # depends_on = [aws_acm_certificate.cert]
  zone_id   = aws_route53_zone.this.zone_id #data.aws_route53_zone.app.zone_id
  name      = aws_acm_certificate.cert.domain_validation_options.0.resource_record_name
  type      = aws_acm_certificate.cert.domain_validation_options.0.resource_record_type
  records   = [aws_acm_certificate.acm_certificate.domain_validation_options.0.resource_record_value]
  ttl       = "60"

  alias {
    name    = aws_lb.public.dns_name
    zone_id = aws_lb.public.zone_id
    evaluate_target_health  = true
  }
}