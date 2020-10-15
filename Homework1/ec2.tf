variable "aws_access_key" {}
variable "aws_secret_key" {}
variable "private_key_path" {}
variable "key_name" {}



# data "aws_ami" "aws_linux_2" {
#     most_recent      = true
#     owners = ["amazon"]
# }


resource "aws_default_vpc" "default" { 

}

##### there shoudnt be rescource per rule?

resource "aws_security_group" "allow_ngix" {
    name = "nginx_demo"
    description = "Allow prot 80 and 22"
    # vpc_id = aws_default_vpc.default.index

    ingress {
        from_port = 22
        to_port = 22 
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port = 80
        to_port = 80 
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port = 0
        to_port = 0 
        protocol = -1
        cidr_blocks = ["0.0.0.0/0"]
    }
}


### what is the .id that we are using? 
resource "aws_instance" "test" {
    count = 2
    ami = "ami-0528a5175983e7f28"
    instance_type = "t2.medium"
    key_name = var.key_name
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
