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