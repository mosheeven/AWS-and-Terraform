variable "aws_access_key" {}
variable "aws_secret_key" {}
variable "private_key_path" {}

variable "region" {
    default = "us-east-2"
}

variable "ec2_count" {
    default = 2
}

variable "key_name" {
    default = "moshe-east-2"
}
