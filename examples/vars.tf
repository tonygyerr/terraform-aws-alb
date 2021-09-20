variable "app_name" {
  type        = string
  description = "Application"
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

variable "public_subnet_ids" {
  description = "list of subnet ids"
  type        = list
  default     = []
}

variable "route53_zone_name" {
  description = "The Route53 Zone name"
  type        = string
  default     = ""
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

variable "vpc_config" {
  description = "configuration option for vpc"
  type        = map(string)
}

variable "vpc_name" {
  description = "configuration option for vpc"
  type        = string
}

variable "asg_name" {
  description = "Name of the autoscaled ec2 instance"
  type        = string
}

variable "deploy_env_map" {
  type = map
  default = {
    dev = "develop"
    test = "test"
    prod = "prod"
  }
}

variable "load_balancer_type" {
  description = "The type of load balancer to create"
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
