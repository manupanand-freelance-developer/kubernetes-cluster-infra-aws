data "aws_route53_zone" "zone_id" {
  name= var.domain-name
}