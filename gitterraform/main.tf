module "AWS" {
  source = "./AWS"

  region = "ap-northeast-2"
  vpc_prefix = "STG"
  vpc_cidr = "10.0.0.0/16"
}

terraform {
  backend "s3" {
    bucket         = "hgc-tfstate-bucket" 
    key            = "state/terraform.tfstate"
    region         = "ap-northeast-2"              
    dynamodb_table = "terraform-lock"         
    encrypt        = true                   
    versioning     = true                  
  }
}
