variable "region" {
    default = "us-east-2"
}


variable "ec2_count" {
    default = 2
}


variable "key_name" {
    default = "moshe-east-2"
}


# variable "vpc_cidr" {
#     default = "10.0.0.0/16"
# }

# variable "public_subnet_vpc" {
#     default = ["10.0.10.0/24", "10.0.11.0/24"]
# }

# variable "private_subnet_vpc" {
#     default = ["10.0.20.0/24","10.0.21.0/24"]
# }

# variable "AZ" {
#     default = ["us-east-2a", "us-east-2b", "us-east-2c", "us-east-2d"]
# }