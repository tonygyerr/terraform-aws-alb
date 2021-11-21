# output "route53_zone_zone_id" {
#   description = "Zone ID of Route53 zone"
#   value       = aws_route53_zone.this.zone_id
# }

# output "route53_zone_name_servers" {
#   description = "Name servers of Route53 zone"
#   value       = aws_route53_zone.this.name_servers
# }

# output "route53_zone_name" {
#   description = "Name of Route53 zone"
#   value       = aws_route53_zone.this.name
# }

# # output "route53_record_name" {
# #   description = "The name of the record"
# #   value       = aws_route53_record.this[each.key].name
# # }

# # output "route53_record_fqdn" {
# #   description = "FQDN built using the zone domain and name"
# #   value       = aws_route53_record.this[each.key].fqdn
# # }

# output "route53_record_name" {
#   description = "The name of the record"
#   value       = { for k, v in aws_route53_record.this : k => v.name }
# }

# output "route53_record_fqdn" {
#   description = "FQDN built using the zone domain and name"
#   value       = { for k, v in aws_route53_record.this : k => v.fqdn }
# }

output "alb_target_group_http_arn"{
  description = "Alb Target Group ARN"
  value = aws_lb_target_group.http.arn
}

output "alb_target_group_https_arn"{
  description = "Alb Target Group ARN"
  value = aws_lb_target_group.https.arn
}

output "alb_target_group_django_arn"{
  description = "Alb Target Group ARN"
  value = aws_lb_target_group.django.arn
}

output "alb_target_group_web_arn"{
  description = "Alb Target Group ARN"
  value = aws_lb_target_group.web.arn
}

output "alb_target_group_web_https_arn"{
  description = "Alb Target Group ARN"
  value = aws_lb_target_group.web_https.arn
}
