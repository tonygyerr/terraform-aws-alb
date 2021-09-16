resource "aws_security_group" "app" {
  name        = "${var.app_name}-alb-sg"
  description = "Application Security Group"
  vpc_id      = var.vpc_config.vpc_id 

  ingress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [var.vpc_config.cidr]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = [var.vpc_config.cidr]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [var.vpc_config.cidr]
  }

  ingress {
    from_port   = 8000
    to_port     = 9000
    protocol    = "tcp"
    cidr_blocks = [var.vpc_config.cidr]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = 6
    description = ""
    cidr_blocks = [var.vpc_config.cidr]
  }

  egress {
    from_port   = 0
    to_port     = 65535
    protocol    = 0
    description = ""
    cidr_blocks = [var.vpc_config.open_cidr]
  }
}

resource "aws_security_group_rule" "app"{
  type = "ingress"
  from_port   = 0 
  to_port     = 65535 
  protocol    = "tcp"
  security_group_id = aws_security_group.app.id
  source_security_group_id = aws_security_group.app.id
}