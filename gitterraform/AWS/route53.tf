resource "aws_route53_zone" "main" {
  name = "gitchang.store"
}

resource "aws_route53_zone" "zone" {
  name = "${lower(var.vpc_prefix)}.${aws_route53_zone.main.name}"

  tags = {
    Environment = var.vpc_prefix
  }
}

resource "aws_route53_record" "A_record" {
  zone_id = aws_route53_zone.main.zone_id
  name    = "${lower(var.vpc_prefix)}.gitchang.store"
  type    = "A"
  ttl     = "30"
  records = aws_route53_zone.zone.name_servers
}
