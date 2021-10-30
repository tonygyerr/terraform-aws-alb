resource "aws_security_group" "app" {
  name        = "${var.app_name}-alb-sg"
  description = "Application Security Group"
  vpc_id      = var.vpc_config.vpc_id 

  ingress_with_cidr_blocks = [
    {
      from_port   = 80
      to_port     = 80
      protocol    = 6
      description = ""
      cidr_blocks = var.vpc_config.vpc_id
    },
    {
      from_port   = 8000
      to_port     = 8000
      protocol    = 6
      description = ""
      cidr_blocks = var.vpc_config.vpc_id
    },
    {
      from_port   = 443
      to_port     = 443
      protocol    = 6
      description = ""
      cidr_blocks = var.vpc_config.vpc_id
    },
    {
      from_port   = 80
      to_port     = 80
      protocol    = 6
      description = ""
      cidr_blocks = var.vpc_config.vpc_id
    },
  ]

  egress_with_cidr_blocks = [
    {
      from_port   = 0
      to_port     = 65535
      protocol    = -1
      description = ""
      cidr_blocks = "0.0.0.0/0"
    }
  ]
}

resource "aws_security_group_rule" "http"{
  type = "ingress"
  from_port   = 80
  to_port     = 80
  protocol    = "tcp"
  security_group_id = aws_security_group.app.id
  source_security_group_id = aws_security_group.app.id
}

resource "aws_security_group_rule" "app"{
  type = "ingress"
  from_port   = 8000
  to_port     = 8000
  protocol    = "tcp"
  security_group_id = aws_security_group.app.id
  source_security_group_id = aws_security_group.app.id
}

resource "aws_security_group_rule" "https"{
  type = "ingress"
  from_port   = 443
  to_port     = 443 
  protocol    = "tcp"
  security_group_id = aws_security_group.app.id
  source_security_group_id = aws_security_group.app.id
}