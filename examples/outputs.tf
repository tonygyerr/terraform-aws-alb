# # output "asg_launch_configuration_id" {
# #   description = "launch configuration ID"
# #   value       = "${module.asg.asg_launch_configuration_id}"
# # }

# # output "asg_autoscaling_group_id" {
# #   description = "autoscaling group id"
# #   value       = "${module.asg.asg_autoscaling_group_id}"
# # }

# # output "asg_autoscaling_group_name" {
# #   description = "autoscaling group name"
# #   value       = "${module.asg.asg_autoscaling_group_name}"
# # }

# output "route53_zone_zone_id" {
#   description = "Zone ID of Route53 zone"
#   value       = module.alb.route53_zone_zone_id
# }

# output "route53_zone_name_servers" {
#   description = "Name servers of Route53 zone"
#   value       = module.alb.route53_zone_name_servers
# }

# output "route53_zone_name" {
#   description = "Name of Route53 zone"
#   value       = module.alb.route53_zone_name
# }

# # records
# output "route53_record_name" {
#   description = "The name of the record"
#   value       = module.alb.route53_record_name
# }

# output "route53_record_fqdn" {
#   description = "FQDN built using the zone domain and name"
#   value       = module.alb.route53_record_fqdn
# }

output "alb_target_group_https_arn" {
  description = "Alb Target Group ARN"
  value       = module.alb.alb_target_group_https_arn
}

output "alb_target_group_http_arn" {
  description = "Alb Target Group ARN"
  value       = module.alb.alb_target_group_http_arn
}

output "alb_target_group_django_arn" {
  description = "Alb Target Group ARN"
  value       = module.alb.alb_target_group_django_arn
}

output "alb_target_group_web_arn" {
  description = "Alb Target Group ARN"
  value       = module.alb.alb_target_group_web_arn
}

output "alb_target_group_web_https_arn" {
  description = "Alb Target Group ARN"
  value       = module.alb.alb_target_group_web_https_arn
}