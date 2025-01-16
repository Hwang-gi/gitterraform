module "AWS" {
  source = "./AWS"

  region = "ap-northeast-2"
  vpc_prefix = "STG"
  vpc_cidr = "10.0.0.0/16"
}
