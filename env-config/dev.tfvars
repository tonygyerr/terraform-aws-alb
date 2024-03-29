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

vpc_name  = ""
public_subnet_ids = [""]

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
lb_logs_bucket              = ""
lb_logs_prefix              = "logs"
load_balancer_type          = "application"
port_http                   = "80"
health_port_http            = "traffic-port"

#--------------------------------------------------------------
# route53
#--------------------------------------------------------------
route53_zone_name           = "my-app.com"
tls_ppk_filename            = "" #"examples/resources/cert.ppk"
tls_ppk_filename            = "" #"examples/resources/cert.pem"
tls_common_name             = "my-app.domain.com"
tls_organization            = "My Company"
