#data "aws_route53_zone" "app" {
#    name            = var.route53_zone_name
#    private_zone    = true
#}

data "aws_acm_certificate" "app" {
  domain          = var.route53_zone_name
  statuses        = ["ISSUED"]
  most_recent     = true
}

data "aws_availability_zones" "main" {}

data "aws_caller_identity" "current" {}

data "aws_availability_zones" "available" {
  state = "available"
}

data "aws_iam_account_alias" "current" {}

# data "aws_autoscaling_group" "server" {
#   name = "my-asg-name"
# }
