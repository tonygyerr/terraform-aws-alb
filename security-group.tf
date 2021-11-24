resource "aws_security_group" "app" {
  name        = "${var.app_name}-alb-sg"
  description = "Application Security Group"
  vpc_id      = var.vpc_config.vpc_id 

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [var.vpc_config.cidr.open_cidr] # set to open if a public internet facing loadbalancer # if internal load balancer set to vpc_cidr subnet range or needed range for your application
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [var.vpc_config.cidr.open_cidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = [var.vpc_config.open_cidr]
  }
}