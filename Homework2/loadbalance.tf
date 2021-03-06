resource "aws_lb" "public_lb" {
  name               = "test-lb-tf"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.lb_sg.id]
  subnets            = [aws_subnet.public_moshe[0].id,aws_subnet.public_moshe[1].id]
  tags = {
    Environment = "test"
  }
}

resource "aws_lb_listener" "web_machines" {
  load_balancer_arn = aws_lb.public_lb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg_web.arn
  }
}

resource "aws_lb_target_group" "tg_web" {
  name     = "nginx-servers"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.main.id
  target_type = "ip"
}

resource "aws_lb_target_group_attachment" "test" {
  count = var.ec2_count
  target_group_arn = aws_lb_target_group.tg_web.arn
  target_id        = aws_instance.web_server[count.index].private_ip
  port             = 80
}
