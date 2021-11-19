# resource "aws_route53_zone" "this" {
#   # count = var.load_balancer_type == "application" ? 0 : 1
#   name = var.route53_zone_name

#   vpc {
#     vpc_id = var.vpc_config.vpc_id #data.aws_vpc.computer_vision.id
#   }
# }

# # resource "aws_route53_record" "this" {
# #   # count      = var.load_balancer_type == "application" ? 0 : 1
# #   name = "${var.app_name}-route53-record"
# #   allow_overwrite = true
# #   # depends_on = [aws_acm_certificate.cert]
# #   zone_id   = aws_route53_zone.this.zone_id #data.aws_route53_zone.app.zone_id
# #   # name      = aws_acm_certificate.cert.domain_validation_options.0.resource_record_name
# #   type      = aws_acm_certificate.cert.domain_validation_options.0.resource_record_type
# #   # records   = [aws_acm_certificate.cert.domain_validation_options.0.resource_record_value]

# #   alias {
# #     name    = aws_lb.public.dns_name
# #     zone_id = aws_lb.public.zone_id
# #     evaluate_target_health  = true
# #   }
# # }

# resource "aws_route53_record" "this" {
#   allow_overwrite = true
#   for_each = {
#     for dvo in aws_acm_certificate.cert.domain_validation_options : dvo.domain_name => {
#       name   = dvo.resource_record_name
#       record = dvo.resource_record_value
#       type   = dvo.resource_record_type
#     }
#   }

#   name            = each.value.name
#   records         = [each.value.record]
#   ttl             = 60
#   type            = each.value.type
#   zone_id         = aws_route53_zone.this.zone_id #data.aws_route53_zone.app.zone_id
# }