output "route53_zone_zone_id" {
  description = "Zone ID of Route53 zone"
  value       = aws_route53_zone.this.zone_id
}

output "route53_zone_name_servers" {
  description = "Name servers of Route53 zone"
  value       = aws_route53_zone.this.name_servers
}

output "route53_zone_name" {
  description = "Name of Route53 zone"
  value       = aws_route53_zone.this.name
}

output "route53_record_name" {
  description = "The name of the record"
  value       = aws_route53_record.this[count.index].name
}

output "route53_record_fqdn" {
  description = "FQDN built using the zone domain and name"
  value       = aws_route53_record.this[count.index].fqdn
}