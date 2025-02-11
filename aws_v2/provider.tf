terraform {
  required_version = ">= 1.4.0"
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = ">= 5.86.0"
    }
    kubernetes = {
       source = "hashicorp/kubernetes"
       version = "~> 2.35"
    }
    kubectl = {
       source = "gavinbunney/kubectl"
       version = "~> 1.19"
    }
  }
}

provider "aws" {
  region = var.AWS_REGION
  access_key = var.AWS_ACCESS_KEY_ID
  secret_key = var.AWS_SECRET_ACCESS_KEY
}

provider "kubernetes" {
host                   = "https://your-cluster-api-endpoint"
cluster_ca_certificate = base64decode("")
token                  = ""
 }

provider "kubectl" {
  config_path = "~/.kube/config"
}
