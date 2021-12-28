provider "aws" {
  version = "~> 2.0"
  region  = var.aws_region
  profile = var.profile
}

terraform {
  backend "s3" {
  }
}