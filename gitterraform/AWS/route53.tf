resource "aws_route53_zone" "main" {
  name = "gitchang.store"
}

resource "aws_route53_zone" "stg" {
  name = "${lower(var.vpc_prefix)}.${aws_route53_zone.main.name}"

  tags = {
    Environment = var.vpc_prefix
  }
}

resource "aws_route53_record" "stg-ns" {
  zone_id = aws_route53_zone.main.zone_id
  name    = "stg.gitchang.store"
  type    = "NS"
  ttl     = "30"
  records = aws_route53_zone.stg.name_servers
}
