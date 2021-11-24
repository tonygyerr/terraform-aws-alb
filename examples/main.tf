module "alb" {
  source = "git::ssh://git@github.com:tonygyerr/terraform-aws-alb.git"
  app_name              = var.app_name
  asg_name              = var.asg_name
  internal              = var.internal
  load_balancer_type    = var.load_balancer_type
  lb_logs_bucket        = var.lb_logs_bucket
  lb_logs_prefix        = var.lb_logs_prefix
  public_subnet_ids     = var.public_subnet_ids
  route53_zone_name     = var.route53_zone_name
  tls_pem_filename      = var.tls_pem_filename
  tls_ppk_filename      = var.tls_ppk_filename
  validation_record_fqdn  = var.validation_record_fqdn
  vpc_config            = var.vpc_config
  vpc_name              = var.vpc_name
  tags                  = merge(map("Name", local.environment_name != local.tf_workspace ? "${local.tf_workspace}-${var.app_name}-alb" : "${var.app_name}-alb"), merge(var.tags))
}