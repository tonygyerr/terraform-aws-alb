#resource "tls_private_key" "this" {
#  algorithm = "RSA"
#}
#
#resource "tls_self_signed_cert" "this" {
#  key_algorithm   = "RSA"
#  private_key_pem = tls_private_key.this.private_key_pem
#
#  subject {
#    common_name  = var.tls_common_name 
#    organization = var.tls_organization
#  }
#
#  validity_period_hours = 12
#
#  allowed_uses = [
#    "key_encipherment",
#    "digital_signature",
#    "server_auth",
#  ]
#}
