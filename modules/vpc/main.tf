
# vpc
resource "aws_vpc" "main" {
  cidr_block       = var.vpc_cidr
  enable_dns_hostnames = "true" 

  tags = {
    Name = "moshe_vpc"
  }
}

# internet gateway
resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.main.id
}

# EIP
resource "aws_eip" "ip_nat"{
    vpc = "true"
}

# NAT
resource "aws_nat_gateway" "gw" {
  allocation_id = aws_eip.ip_nat.id
  subnet_id     = aws_subnet.public_moshe[0].id
}


# public subnet
resource "aws_subnet" "public_moshe" {
    count = 2
    vpc_id = aws_vpc.main.id
    cidr_block = var.public_subnet_vpc[count.index]
    # availability_zone = data.aws_availability_zones.available.names[0]
    availability_zone = var.AZ[count.index]
    tags = {
        Name = "public_subnet"
    }
}

# private subnet
resource "aws_subnet" "private_moshe" {
    count = 2
    vpc_id = aws_vpc.main.id
    cidr_block = var.private_subnet_vpc[count.index]
    # availability_zone = data.aws_availability_zones.available.names[1]
    availability_zone = var.AZ[count.index]
    tags = {
        Name = "private_subnet"
    }
}

## route table
# route table public
resource "aws_route_table" "r_public" {
    vpc_id = aws_vpc.main.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw.id
    }

    tags = {
        Name = "route_to_igw"
    }
}

# route table private
resource "aws_route_table" "r_private" {
    vpc_id = aws_vpc.main.id
    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = aws_nat_gateway.gw.id
    }

    tags = {
        Name = "route_to_nat"
    }
}

# route table assosiation
resource "aws_route_table_association" "public" {
  count = 2
  subnet_id      = aws_subnet.public_moshe[count.index].id
  route_table_id = aws_route_table.r_public.id
}

# route table assosiation
resource "aws_route_table_association" "private" {
  count = 2
  subnet_id      = aws_subnet.private_moshe[count.index].id
  route_table_id = aws_route_table.r_private.id
}

