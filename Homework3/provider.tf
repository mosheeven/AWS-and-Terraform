provider "aws" {
    region = var.region
}

terraform {
  backend "s3" {
    bucket         = "tf-us-east-2-state"
    key            = "global/s3/terraform.tfstate"
    region         = "us-east-2"
    encrypt        = true
  }
}