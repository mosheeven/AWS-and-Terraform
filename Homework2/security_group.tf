resource "aws_security_group" "allow_ngix" {
    name = "nginx_demo"
    description = "Allow prot 80 and 22"
    vpc_id = aws_vpc.main.id

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
        # cidr_blocks = ["0.0.0.0/0"]
        security_groups = [aws_security_group.lb_sg.id]
    }

    egress {
        from_port = 0
        to_port = 0 
        protocol = -1
        cidr_blocks = ["0.0.0.0/0"]
    }
}

# alb sg
resource "aws_security_group" "lb_sg" {
    name = "lb_nginx"

    description = "Allow prot 80"
    vpc_id = aws_vpc.main.id
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