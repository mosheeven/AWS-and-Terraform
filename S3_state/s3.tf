provider "aws" {
  region = "us-east-2"
}

resource "aws_s3_bucket" "terraform_state" {
  bucket = "just-create-bucket23323"
  versioning {
    enabled = true
  }
}

terraform {
  backend "s3" {
    bucket         = "tf-us-east-2-state"
    key            = "global/s3/terraform.tfstate"
    region         = "us-west-2"
    encrypt        = true
  }
}