# S3 bucket for backend
resource "aws_s3_bucket" "tfstate" {
  bucket = "hgc-tfstate-bucket"

  versioning {
    enabled = true
  }

  tags = {
    Name = "hgc-tfstate-bucket"
    Environment = "${var.vpc_prefix}"
  }
}

# DynamoDB for terraform state lock
resource "aws_dynamodb_table" "terraform_state_lock" {
  name           = "terraform-lock"
  hash_key       = "LockID"
  billing_mode   = "PAY_PER_REQUEST"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name = "terraform-lock"
  }
}

terraform {
  backend "s3" {
    bucket         = "hgc-tfstate-bucket" 
    key            = "path/to/terraform.tfstate"
    region         = "us-east-1"              
    dynamodb_table = "terraform-lock"         
    encrypt        = true                   
    versioning     = true                  
  }
}
