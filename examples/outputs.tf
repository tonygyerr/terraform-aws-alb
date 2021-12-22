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