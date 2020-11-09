data "aws_availability_zones" "available"{
  state = "available"
}

module "network" {
  source = "../modules/vpc"
  
  vpc_cidr = "10.0.0.0/16"
  private_subnet_vpc = ["10.0.20.0/24","10.0.21.0/24"]
  public_subnet_vpc = ["10.0.10.0/24", "10.0.11.0/24"]
  # AZ = ["us-east-2a", "us-east-2b", "us-east-2c", "us-east-2d"]
  AZ = data.aws_availability_zones.available.names
}