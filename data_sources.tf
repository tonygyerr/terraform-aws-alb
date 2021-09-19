#data "aws_route53_zone" "app" {
#    name            = var.route53_zone_name
#    private_zone    = true
#}

# data "aws_acm_certificate" "acn" {
#     domain          = var.route53_zone_name
#     statuses        = ["PENDING_VALIDATION"]
#     # provider        = "aws.virginia"
# }

data "aws_availability_zones" "main" {}

data "aws_caller_identity" "current" {}

data "aws_availability_zones" "available" {
  state = "available"
}

data "aws_iam_account_alias" "current" {}

data "null_data_source" "environment" {
  inputs = "${map(
    "SDLC",
    lower(
      element(
        split("-", data.aws_iam_account_alias.current.account_alias),
        length(split("-", data.aws_iam_account_alias.current.account_alias)) - 1
    ))
  )}"
}

# data "aws_autoscaling_group" "server" {
#   name = "my-asg-name"
# }