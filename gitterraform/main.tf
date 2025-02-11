terraform {
  required_version = ">= 0.13"
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = ">= 5.0"
    }
    kubernetes = {
      source = "hashicorp/kubernetes"
      version = >= 2.0"
    }
    kubectl = {
      source = "bnu0/kubectl"
      version = ">= 1.7.0"
    }
  }
}

provider "aws" {
  region = var.AWS_REGION
  access_key = var.AWS_ACCESS_KEY_ID
  secret_key = var.AWS_SECRET_ACCESS_KEY
}

module "AWS" {
  source = "./AWS"

  region = "ap-northeast-2"
  vpc_prefix = "STG"
  vpc_cidr = "10.0.0.0/16"
  zone_name = "gitchang.store"
}
