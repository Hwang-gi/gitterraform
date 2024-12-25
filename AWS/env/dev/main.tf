provider "aws" {
  region = "ap-northeast-2"
}

module "network" {
  source    = "../../modules/network"
  vpc_name  = "DEV"
  vpc_cidr  = "10.0.0.0/16"
  availability_zones = ["ap-northeast-2a", "ap-northeast-2c"]

}

module "security" {
  source    = "../../modules/security"
}

module "storage" {
  source    = "../../modules/storage"
  vpc_name  = "DEV"
}
