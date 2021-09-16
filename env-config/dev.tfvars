#--------------------------------------------------------------
# general
#--------------------------------------------------------------
app_name   = "app"
vpc_config = {
  region            = "us-east-1"
  cidr              = "10.0.0.0/16"
  open_cidr         = "0.0.0.0/0"
  number_of_subnets = "3"
  instance_tenancy  = "default"
  vpc_id            = ""
}

public_subnet_ids = ["subnet-0d0a753d91527cf8e", "subnet-03834ff9536eb40f6"]

tags = {
  Owner       = "user"
  Environment = "dev"
  Region      = "us-east-1"
  Owner       = "app"
  CostCenter  = "app"
}

#--------------------------------------------------------------
# alb
#--------------------------------------------------------------
lb_logs_bucket              = "echo-jenkins-bucket"
lb_logs_prefix              = "logs"
load_balancer_type          = "application"

#--------------------------------------------------------------
# route53
#--------------------------------------------------------------
route53_zone_name           = "jenkins-app.com"