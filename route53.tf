resource "aws_route53_zone" "this" {
  name = var.route53_zone_name

  vpc {
    vpc_id = var.vpc_config.vpc_id #data.aws_vpc.computer_vision.id
  }
}

resource "aws_route53_record" "jenkins" {
  count     = var.ec2_instance_count
  zone_id   = aws_route53_zone.this.zone_id #data.aws_route53_zone.app.zone_id
  name      = aws_acm_certificate.acm_certificate.domain_validation_options.0.resource_record_name
  type      = aws_acm_certificate.acm_certificate.domain_validation_options.0.resource_record_type
  # records   = [aws_acm_certificate.acm_certificate.domain_validation_options.0.resource_record_value")]
  # ttl       = "60"

  alias {
    name    = aws_lb.public.dns_name
    zone_id = aws_lb.public.zone_id
    evaluate_target_health  = true
  }
}