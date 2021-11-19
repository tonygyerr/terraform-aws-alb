resource "aws_lb" "public" {
  name                             = "${var.app_name}-alb"
  internal                         = true
  load_balancer_type               = var.load_balancer_type
  enable_cross_zone_load_balancing = var.enable_cross_zone_load_balancing
  security_groups                  = [aws_security_group.app.id] #[var.security_groups]
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
  port              = var.port_http     #443 #"80"
  protocol          = var.protocol_http #HTTPS #"HTTP"

  default_action {
    target_group_arn = aws_lb_target_group.http.arn
    type             = "forward"
  }
}

resource "aws_lb_listener_rule" "host_based_routing" {
  count        = var.load_balancer_type == "application" ? 0 : 1
  listener_arn = aws_lb_listener.http.arn
  priority     = var.priority

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.http.arn
  }

  condition {
    field  = var.field
    values = [var.values]
  }
}

resource "aws_lb_listener" "https" {
  load_balancer_arn = aws_lb.public.arn
  port              = var.port_https    #443 #"80"
  protocol          = var.protocol_https #HTTPS #"HTTP"
  ssl_policy        = var.protocol_https == "TLS" ? var.ssl_policy : ""
  certificate_arn   = data.aws_acm_certificate.app.arn

  default_action {
    target_group_arn = aws_lb_target_group.https.arn
    type             = "forward"
  }
}

resource "aws_alb_listener_certificate" "https" {
  listener_arn = aws_lb_listener.https.arn  
  certificate_arn = data.aws_acm_certificate.app.arn
  
}

resource "aws_lb_listener" "django" {
  load_balancer_arn = aws_lb.public.arn
  port              = 8000    #443 #"80"
  protocol          = var.protocol_https #HTTPS #"HTTP"
  ssl_policy        = var.protocol_https == "TLS" ? var.ssl_policy : ""
  certificate_arn   = data.aws_acm_certificate.app.arn

  default_action {
    target_group_arn = aws_lb_target_group.django.arn
    type             = "forward"
  }
}

resource "aws_lb_listener" "web" {
  load_balancer_arn = aws_lb.public.arn
  port              = 8001    #443 #"80"
  protocol          = var.protocol_https #HTTPS #"HTTP"
  ssl_policy        = var.protocol_https == "TLS" ? var.ssl_policy : ""
  certificate_arn   = data.aws_acm_certificate.app.arn

  default_action {
    target_group_arn = aws_lb_target_group.web.arn
    type             = "forward"
  }
}

resource "aws_lb_listener" "web_https" {
  load_balancer_arn = aws_lb.public.arn
  port              = 8000    #443 #"80"
  protocol          = var.protocol_https #HTTPS #"HTTP"
  ssl_policy        = var.protocol_https == "TLS" ? var.ssl_policy : ""
  certificate_arn   = data.aws_acm_certificate.app.arn

  default_action {
    target_group_arn = aws_lb_target_group.web_https.arn
    type             = "forward"
  }
}


resource "aws_lb_target_group" "https" {
  name     = "${var.app_name}-alb-https-tg"
  port     = var.target_port_https
  protocol = var.target_protocol_https #"HTTPS"
  vpc_id   = var.vpc_config.vpc_id #data.aws_vpc.computer_vision.id #
  
  health_check {
    path              = var.path
    interval          = var.interval
    port              = var.port_https
    protocol          = var.protocol_https
    timeout           = var.load_balancer_type == "network" ? null : var.timeout
    healthy_threshold = var.healthy_threshold
    unhealthy_threshold = var.unhealthy_threshold
    matcher             = var.load_balancer_type == "network" ? null : var.matcher
  }

  stickiness {
    enabled = false
    type = "lb_cookie"
  }

  tags                  = merge(map("Name", local.environment_name != local.tf_workspace ? "${local.tf_workspace}-${var.app_name}-alb-https-tg" : "${var.app_name}-tg"), merge(var.tags, var. acn_tags))
}

resource "aws_lb_target_group" "http" {
  name     = "${var.app_name}-alb-http-tg"
  port     = var.target_port_http
  protocol = var.target_protocol_http #"HTTPS"
  vpc_id   = var.vpc_config.vpc_id #data.aws_vpc.computer_vision.id #
  
  health_check {
    path              = var.path
    interval          = var.interval
    port              = var.port_http
    protocol          = var.protocol_http
    timeout           = var.load_balancer_type == "network" ? null : var.timeout
    healthy_threshold = var.healthy_threshold
    unhealthy_threshold = var.unhealthy_threshold
    matcher             = var.load_balancer_type == "network" ? null : var.matcher
  }

  stickiness {
    enabled = false
    type = "lb_cookie"
  }

  tags                  = merge(map("Name", local.environment_name != local.tf_workspace ? "${local.tf_workspace}-${var.app_name}-alb-http-tg" : "${var.app_name}-tg"), merge(var.tags, var. acn_tags))
}

resource "aws_lb_target_group" "django" {
  name     = "${var.app_name}-alb-django-tg"
  port     = "8000"
  protocol = var.target_protocol_https #"HTTPS"
  vpc_id   = var.vpc_config.vpc_id #data.aws_vpc.computer_vision.id #
  
  health_check {
    path              = var.path
    interval          = var.interval
    port              = "8000"
    protocol          = var.protocol_https
    timeout           = var.load_balancer_type == "network" ? null : var.timeout
    healthy_threshold = var.healthy_threshold
    unhealthy_threshold = var.unhealthy_threshold
    matcher             = var.load_balancer_type == "network" ? null : var.matcher
  }

  stickiness {
    enabled = false
    type = "lb_cookie"
  }

  tags                  = merge(map("Name", local.environment_name != local.tf_workspace ? "${local.tf_workspace}-${var.app_name}-alb-django-tg" : "${var.app_name}-tg"), merge(var.tags, var. acn_tags))
}

resource "aws_lb_target_group" "web" {
  name     = "${var.app_name}-alb-web-tg"
  port     = "8001"
  protocol = var.target_protocol_https #"HTTPS"
  vpc_id   = var.vpc_config.vpc_id #data.aws_vpc.computer_vision.id #
  
  health_check {
    path              = var.path
    interval          = var.interval
    port              = "8001"
    protocol          = var.protocol_https
    timeout           = var.load_balancer_type == "network" ? null : var.timeout
    healthy_threshold = var.healthy_threshold
    unhealthy_threshold = var.unhealthy_threshold
    matcher             = var.load_balancer_type == "network" ? null : var.matcher
  }

  stickiness {
    enabled = false
    type = "lb_cookie"
  }

  tags                  = merge(map("Name", local.environment_name != local.tf_workspace ? "${local.tf_workspace}-${var.app_name}-alb-web-tg" : "${var.app_name}-tg"), merge(var.tags, var. acn_tags))
}

resource "aws_lb_target_group" "web_https" {
  name     = "${var.app_name}-alb-web-https-tg"
  port     = "8002"
  protocol = var.target_protocol_https #"HTTPS"
  vpc_id   = var.vpc_config.vpc_id #data.aws_vpc.computer_vision.id #
  
  health_check {
    path              = var.path
    interval          = var.interval
    port              = "8002"
    protocol          = var.protocol_https
    timeout           = var.load_balancer_type == "network" ? null : var.timeout
    healthy_threshold = var.healthy_threshold
    unhealthy_threshold = var.unhealthy_threshold
    matcher             = var.load_balancer_type == "network" ? null : var.matcher
  }

  stickiness {
    enabled = false
    type = "lb_cookie"
  }

  tags                  = merge(map("Name", local.environment_name != local.tf_workspace ? "${local.tf_workspace}-${var.app_name}-alb-web-https-tg" : "${var.app_name}-tg"), merge(var.tags, var. acn_tags))
}

# resource "aws_autoscaling_attachment" "server" {
#   alb_target_group_arn   = aws_lb_target_group.https.arn
#   autoscaling_group_name = data.aws_autoscaling_group.server.id
# }