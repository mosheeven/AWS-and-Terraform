variable "aws_access_key" {}
variable "aws_secret_key" {}
variable "private_key_path" {}
variable "key_name" {}
variable "region" {
    default = "us-east-2"
}

data "aws_ami" "ubuntu-18_04" {
    most_recent = true
    owners = ["099720109477"]

    filter {
        name   = "name"
        values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-20200908"]
    }
    filter {
        name   = "architecture"
        values = ["x86_64"]
    }


}


resource "aws_instance" "test" {
    count = 2
    ami = data.aws_ami.ubuntu-18_04.id
    # ami ="ami-0e82959d4ed12de3f"
    instance_type = "t2.micro"
    # key_name = var.key_name
    vpc_security_group_ids = [aws_security_group.allow_ngix.id]
    
    ebs_block_device {
        device_name = "/dev/sdg"
        volume_type = "gp2"
        volume_size = 10
        encrypted = true
    }

    tags = {
        Name = "nginx server"
        Owner = "Moshe"
        Purpose = "Test"

    }

    user_data = file("./install_ngix.sh")

    # connection {
    #     type = "ssh"
    #     host = self.public_ip
    #     user = "ec2-user"
    #     private_key = file(var.private_key_path)

    # }

    # provisioner "remote-exec" {
    # inline = ["sudo yum install nginx -y",
    #             "sudo service nginx start",
    #             "sudo su",
    #             "sudo echo \"<h1> OpsSchool Rules </h1>\" > /usr/share/nginx/html/index.html",
    #             "exit"]

    # }
}


output "aws_instance_public_dns_1" {
    value = aws_instance.test[0].public_dns
}

output "aws_instance_public_dns_2" {
    value = aws_instance.test[1].public_dns
}
