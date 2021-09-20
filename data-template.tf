# data "template_file" "pem" {
#   template = "${file("${path.module}/${var.tls_pem_filename}")}"
# }

# data "template_file" "ppk" {
#   template = "${file("${path.module}/${var.tls_ppk_filename}")}"
# }