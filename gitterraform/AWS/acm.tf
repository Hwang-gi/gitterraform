resource "aws_acm_certificate" "cert" {
  domain_name       = aws_route53_zone.main.name
  validation_method = "DNS"

  tags = {
    Environment = lower(var.vpc_prefix)
  }

  lifecycle {
    create_before_destroy = true
  }
}
