module "AWS" {
  source = "./AWS"

  region = "ap-northeast-2"
  vpc_prefix = "STG"
  vpc_cidr = "10.0.0.0/16"
}

AWS_ACCESS_KEY_ID     = "AKIAWAA66RBQLG5H7QVZ"
AWS_SECRET_ACCESS_KEY = "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"
