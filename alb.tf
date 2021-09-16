resource "aws_lb" "public" {
  name                             = var.lb_name
  internal                         = true
  load_balancer_type               = var.load_balancer_type
  enable_cross_zone_load_balancing = var.enable_cross_zone_load_balancing
  security_groups                  = [aws_security_group.jenkins.id] #[var.security_groups]
  subnets                          = var.public_subnet_ids
  idle_timeout                     = 400
  ip_address_type                  = "ipv4"
  enable_deletion_protection       = false

  dynamic "access_logs" {
    for_each = var.lb_logs_enabled ? ["enabled"] : []
    content {
      bucket  = var.lb_logs_bucket
      prefix  = var.lb_logs_prefix
      enabled = var.lb_logs_enabled
    }
  }
  timeouts {
    create = "30m"
    delete = "30m"
  }

  tags                  = merge(map("Name", local.environment_name != local.tf_workspace ? "${local.tf_workspace}-${var.app_name}-alb" : "${var.app_name}-alb"), merge(var.tags, var. acn_tags))
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.public.arn
  port              = var.port     #443 #"80"
  protocol          = var.protocol #HTTPS #"HTTP"
  # ssl_policy        = var.protocol == "TLS" ? var.ssl_policy : ""
  # certificate_arn   = data.aws_acm_certificate.acn.arn

  default_action {
    target_group_arn = aws_lb_target_group.https.arn
    type             = "forward"
  }
}

resource "aws_lb_listener_rule" "host_based_routing" {
  count        = var.load_balancer_type == "application" ? 0 : 1
  listener_arn = aws_lb_listener.http.arn
  priority     = var.priority

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.https.arn
  }

  condition {
    field  = var.field
    values = [var.values]
  }
}
resource "aws_lb_target_group" "https" {
  name     = "${var.app_name}-alb-tg"
  port     = var.target_port #80
  protocol = var.target_protocol #"HTTPS"
  vpc_id   = data.aws_vpc.computer_vision.id #var.vpc_config.vpc_id
  
  health_check {
    path              = var.path
    interval          = var.interval
    port              = var.port
    protocol          = var.protocol
    timeout           = var.load_balancer_type == "network" ? null : var.timeout
    healthy_threshold = var.healthy_threshold
    unhealthy_threshold = var.unhealthy_threshold
    matcher             = var.load_balancer_type == "network" ? null : var.matcher
  }

  stickiness {
    enabled = false
    type = "lb_cookie"
  }

  tags                  = merge(map("Name", local.environment_name != local.tf_workspace ? "${local.tf_workspace}-${var.app_name}-tg" : "${var.app_name}-tg"), merge(var.tags, var. acn_tags))
}

resource "aws_alb_target_group_attachment" "server" {
  target_group_arn       = aws_lb_target_group.https.arn
  target_id              = data.aws_instance.server.id #var.vpc_config.instance_id
  port                   = 8080
}

# resource "aws_autoscaling_attachment" "server" {
#   alb_target_group_arn   = aws_alb_target_group.alb_target_group.arn
#   autoscaling_group_name = aws_autoscaling_group.svc_asg.id
# }