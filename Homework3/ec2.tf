data "aws_ami" "ubuntu-18_04_with_nginx" {
    most_recent = true
    owners = ["455198789788"]

    filter {
        name   = "name"
        values = ["new_nginx"]
    }
    filter {
        name   = "architecture"
        values = ["x86_64"]
    }
}

# web servers
resource "aws_instance" "web_server" {
    count = var.ec2_count
    # ami = data.aws_ami.ubuntu-18_04.id
    ami = data.aws_ami.ubuntu-18_04_with_nginx.id # this ami is with nginx installed
    instance_type = "t2.micro"
    key_name = var.key_name
    vpc_security_group_ids = [aws_security_group.allow_ngix.id]
    subnet_id = module.network.public_subnet_vpc_ids[count.index]
    associate_public_ip_address = "true"
    iam_instance_profile = "access_s3"
    user_data = file("./user_data.sh")
    tags = {
        Name = "nginx server"
        Owner = "Moshe"
        Purpose = "Test"
    }
}

# DB servers
resource "aws_instance" "DB_server" {
    count = var.ec2_count
    # ami = data.aws_ami.ubuntu-18_04.id
    ami ="ami-0aca7bcb5f6e3ec20"
    instance_type = "t2.micro"
    key_name = var.key_name
    vpc_security_group_ids = [aws_security_group.allow_ngix.id]
    subnet_id = module.network.private_subnet_vpc_ids[count.index]
    associate_public_ip_address = "true"

    tags = {
        Name = "DB server"
        Owner = "Moshe"
        Purpose = "Test"
    }
}
