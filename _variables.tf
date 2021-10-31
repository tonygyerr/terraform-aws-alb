variable "vpc_config" {
  description = "configuration option for vpc"
  type        = map(string)
}

variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
}

variable "asg_name" {
  description = "Name of the autoscaled ec2 instance"
  type        = string
}


variable "app_name" {
  type        = string
  description = "Application"
  default     = ""
}

variable "ec2_instance_count" {
  type        = number
  default     = 1
}

variable "lb_name" {
  type        = string
  description = "load balancer name"
  default     = ""
}

variable "public_subnet_ids" {
  description = "list of subnet ids"
  type        = list
  default     = []
}


variable "security_groups" {
  description = "security groups applied to the load balancer. e.g. [\"sg-ab15ebe3\",\"sg-b012ecf8\"]"
  type        = list
  default     = []
}

variable "tags" {
  type        = map(string)
  description = "optional tags"

  # default = {
  #   name        = ""
  #   owner       = ""
  #   costcenter  = ""
  #   environment = ""
  #   project     = ""
  # }
}

variable "acn_tags" {
  type        = map(string)
  description = "optional tags"

  default = {}
}

variable "route53_name" {
  description = "The name of your Route53 DNS"
  type        = string
  default     = ""
}

variable "route53_zone_name" {
  description = "The Route53 Zone name"
  type        = string
  default     = ""
}

variable "route53_host_name" {
  description = "The Route53 Host name"
  type        = string
  default     = ""
}

variable "route53_record_name" {
  description = "The Route53 Record name"
  type        = string
  default     = ""
}

variable "route53_ttl" {
  description = "The Route53 Time to Live in seconds"
  type        = string
  default     = ""
}

variable "route53_server" {
  description = "The Route53 Server URL"
  type        = string
  default     = ""
}

variable "enable_cross_zone_load_balancing" {
  description = "If true, cross-zone load balancing of the load balancer will be enabled. This is a network load balancer feature."
  type        = bool
  default     = false
}

variable "enable_deletion_protection" {
  description = "If true, cross-zone load balancing of the load balancer will be enabled. This is a network load balancer feature."
  type        = bool
  default     = false
}

variable "load_balancer_type" {
  description = "The type of load balancer to create"
  type        = string
  default     = ""
}

variable "lb_logs_bucket" {
  description = "The S3 Bucket for Logs"
  type        = string
  default     = ""
}

variable "lb_logs_prefix" {
  description = "The S3 Bucket prefix. The logs will be stored at the root level if not configured"
  type        = string
  default     = ""
}

variable "lb_logs_enabled" {
  description = "Boolean to enable/disable acces logs. Defaults to false"
  type        = bool
  default     = false
}

variable "lb_subnet_ids" {
  description = "Enter subnets IDs to attach to the Load Balancer. Submets cannot be updated for Network Load Balancers. Changing of this value will force a new creation of the resource"
  type        = list(string)
  default     = []
}

variable "protocol_http" {
  description = "The protocol for connections from clients to the load balancer. Valid values TCP, TLS, UDP, TCP_UDP, HTTP, and HTTPS."
  type        = string
  default     = "HTTP"
}

variable "protocol_https" {
  description = "The protocol for connections from clients to the load balancer. Valid values TCP, TLS, UDP, TCP_UDP, HTTP, and HTTPS."
  type        = string
  default     = "HTTPS"
}

variable "port_http" {
  description = "The listener port that the load balancer"
  type        = number
  default     = 80
}

variable "port_https" {
  description = "The listener port that the load balancer"
  type        = number
  default     = 443
}

variable "ssl_policy" {
  description = "The SSL Policy for the Load Balancer Listener."
  type        = string
  default     = "ELBSecurityPolicy-TLS-1-2-2017-01"
}

variable "values" {
  type        = string
  default     = "application"
}

variable "certificate_arn" {
  description = "The Certificate ARN to attach to the load balancer if using HTTPS"
  type        = string
  default     = ""
}

variable "target_protocol_https" {
  description = "The protocol for the target instance that the load balancer will forward to.."
  type        = string
  default     = "HTTPS"
}

variable "target_protocol_http" {
  description = "The protocol for the target instance that the load balancer will forward to.."
  type        = string
  default     = "HTTP"
}

variable "target_port_https" {
  description = "The port that the target is listening on"
  type        = number
  default     = 443
}

variable "target_port_http" {
  description = "The port that the target is listening on"
  type        = number
  default     = 80
}

variable "interval" {
  description = "The approximate amount of time, in seconds between health checks for a target. Minimum is 5 seconds, Maximum is 300 seconds."
  type        = number
  default     = 30
}

variable "path" {
  type = string
  description = "The destination for the health check request"
  default     = ""
}

variable "timeout" {
  description = "The approximate amount of time, in seconds in which no response is occuring and resulting in a failed health check. Application Load Balaner range, 2 to 120."
  type        = number
  default     = 6
}

variable "healthy_threshold" {
  type        = number
  default     = 3
}

variable "unhealthy_threshold" {
  type        = number
  default     = 3
}

variable "matcher" {
  description = "The HTTP codes to use when checking for a successful response from a target."
  type        = number
  default     = 200
}

variable "priority" {
  description = "The priority for the rule between 1 to 50000"
  type        = number
  default     = 99
}

variable "field" {
  description = "The name of the field. Values must be either path-pattern (for path based routing) or host-header (for host based routing)."
  type        = string
  default     = "host-header"
}

variable "deploy_env_map" {
  type = map
  default = {
    dev = "develop"
    test = "test"
    prod = "prod"
  }
}

variable "route53_domain_name" {
  description = "The Route53 Domain name"
  type        = string
  default     = ""
}

variable "validation_method" {
  description = "Enter the validation method of your Route53."
  type        = string
  default     = ""
}

variable "validation_record_fqdn" {
  description = "The location of your ppk file"
  type        = string
  default     = ""
}

variable "tls_pem_filename" {
  description = "The location of your pem file"
  type        = string
  default     = ""
}

variable "tls_ppk_filename" {
  description = "The location of your ppk file"
  type        = string
  default     = ""
}