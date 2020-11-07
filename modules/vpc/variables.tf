
variable "vpc_cidr" {
    type = string
}

variable "public_subnet_vpc" {
    type = list
}

variable "private_subnet_vpc" {
    type = list
}

variable "AZ" {
    type = list
}