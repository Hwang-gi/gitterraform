terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = TF_VAR_AWS_REGION
  access_key = TF_VAR_AWS_ACCESS_KEY_ID
  secret_key = TF_VAR_AWS_SECRET_ACCESS_KEY
}

module "AWS" {
  source = "./AWS"

  region = "ap-northeast-2"
  vpc_prefix = "STG"
  vpc_cidr = "10.0.0.0/16"
  zone_name = "gitchang.store"
}
