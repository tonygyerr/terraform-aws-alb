resource "aws_acm_certificate" "acm_certificate" {
  domain_name       = var.route53_domain_name #"app.jenkins-app.com"
  validation_method = var.validation_method #"DNS"
  # tags {
  #   Name = "fatm"
  # }
  lifecycle {
    create_before_destroy = true
  }
}

# resource "aws_acm_certificate_validation" "acm_certificate_validation" {
#   certificate_arn         = aws_acm_certificate.acm_certificate.arn
#   validation_record_fqdns = [aws_route53_record.jenkins.*.fqdn]
# }    