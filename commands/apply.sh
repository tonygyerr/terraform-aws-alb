#!/bin/bash

ENV=$1
AWS_REGION=$2
cd "$(pwd "${0}")/alb" || exit
terraform init -backend-config "backend-config/${ENV}.tfvars"
terraform apply -var-file="env-config/${ENV}.tfvars" -auto-approve