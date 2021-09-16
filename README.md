## Module Application Load Balancer

```hcl
module "alb" {
  source = "git::ssh://git@github.com:tonygyerr/terraform-aws-alb.git"
  app_name              = var.app_name
  lb_logs_bucket        = var.lb_logs_bucket
  lb_logs_prefix        = var.lb_logs_prefix
  public_subnet_ids     = var.public_subnet_ids
  route53_zone_name     = var.route53_zone_name
  vpc_config            = var.vpc_config
  tags                  = var.tags
}
```

## Prerequisites
- Docker (for using Docker Image of dependencies)
- Git
- Terraform
- AWS Key pair for Terraform provisioning.
- AWS S3 bucket for remote terraform state file (tfstate)
- AWS Dynamo Database for tfstate table state lock 

## How to run this Module using Terraform Commands
```bash
cd examples
terraform get
terraform init -backend-config ../backend-config/dev.tfvars
terraform plan -var-file="../env-config/dev.tfvars"
terraform apply -var-file="../env-config/dev.tfvars" -auto-approve
terraform destroy -var-file="../env-config/dev.tfvars"
```

## How to Run this Module using Makefile Process
```bash
make auth
make get
make init
make plan
make apply
```

## Requirements

| Name | Version |
|------|---------|
| aws | ~> 2.0 |

## Providers

| Name | Version |
|------|---------|
| aws | ~> 2.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| acn\_tags | optional tags | `map(string)` | `{}` | no |
| app\_name | Application | `string` | `""` | no |
| certificate\_arn | The Certificate ARN to attach to the load balancer if using HTTPS | `string` | `""` | no |
| ec2\_instance\_count | n/a | `number` | `1` | no |
| enable\_cross\_zone\_load\_balancing | If true, cross-zone load balancing of the load balancer will be enabled. This is a network load balancer feature. | `bool` | `false` | no |
| enable\_deletion\_protection | If true, cross-zone load balancing of the load balancer will be enabled. This is a network load balancer feature. | `bool` | `false` | no |
| field | The name of the field. Values must be either path-pattern (for path based routing) or host-header (for host based routing). | `string` | `"host-header"` | no |
| healthy\_threshold | n/a | `number` | `3` | no |
| interval | The approximate amount of time, in seconds between health checks for a target. Minimum is 5 seconds, Maximum is 300 seconds. | `number` | `30` | no |
| lb\_logs\_bucket | The S3 Bucket for Logs | `string` | `""` | no |
| lb\_logs\_enabled | Boolean to enable/disable acces logs. Defaults to false | `bool` | `false` | no |
| lb\_logs\_prefix | The S3 Bucket prefix. The logs will be stored at the root level if not configured | `string` | `""` | no |
| lb\_name | load balancer name | `string` | `""` | no |
| lb\_subnet\_ids | Enter subnets IDs to attach to the Load Balancer. Submets cannot be updated for Network Load Balancers. Changing of this value will force a new creation of the resource | `list(string)` | `[]` | no |
| load\_balancer\_type | The type of load balancer to create | `string` | `"application"` | no |
| matcher | The HTTP codes to use when checking for a successful response from a target. | `number` | `200` | no |
| path | The destination for the health check request | `string` | `""` | no |
| port | The listener port that the load balancer | `number` | `80` | no |
| priority | The priority for the rule between 1 to 50000 | `number` | `99` | no |
| protocol | The protocol for connections from clients to the load balancer. Valid values TCP, TLS, UDP, TCP\_UDP, HTTP, and HTTPS. | `string` | `"HTTP"` | no |
| public\_subnet\_ids | list of subnet ids | `list` | `[]` | no |
| route53\_domain\_name | The Route53 Domain name | `string` | `""` | no |
| route53\_host\_name | The Route53 Host name | `string` | `""` | no |
| route53\_name | The name of your Route53 DNS | `string` | `""` | no |
| route53\_record\_name | The Route53 Record name | `string` | `""` | no |
| route53\_server | The Route53 Server URL | `string` | `""` | no |
| route53\_ttl | The Route53 Time to Live in seconds | `string` | `""` | no |
| route53\_zone\_name | The Route53 Zone name | `string` | `""` | no |
| security\_groups | security groups applied to the load balancer. e.g. ["sg-ab15ebe3","sg-b012ecf8"] | `list` | `[]` | no |
| ssl\_policy | The SSL Policy for the Load Balancer Listener. | `string` | `"ELBSecurityPolicy-TLS-1-2-2017-01"` | no |
| tags | optional tags | `map(string)` | n/a | yes |
| target\_port | The port that the target is listening on | `number` | `443` | no |
| target\_protocol | The protocol for the target instance that the load balancer will forward to.. | `string` | `"HTTPS"` | no |
| timeout | The approximate amount of time, in seconds in which no response is occuring and resulting in a failed health check. Application Load Balaner range, 2 to 120. | `number` | `6` | no |
| unhealthy\_threshold | n/a | `number` | `3` | no |
| values | n/a | `string` | `"application"` | no |
| vpc\_config | configuration option for vpc | `map(string)` | n/a | yes |

## Outputs

No output.

