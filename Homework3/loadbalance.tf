resource "aws_lb" "public_lb" {
  name               = "test-lb-tf"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.lb_sg.id]
  # subnets            = [module.network.public_subnet_vpc_ids[0], module.network.public_subnet_vpc_ids[1]]
  subnets            = module.network.public_subnet_vpc_ids
  tags = {
    Environment = "test"
  }
  
  access_logs {
    bucket  = "tf-us-east-2-state"
    prefix  = "logs-lb"
    enabled = false
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
  vpc_id   = module.network.vpc_vpc_id
  target_type = "ip"
  stickiness {
    type = "lb_cookie"
    cookie_duration = 60
  }
}

resource "aws_lb_target_group_attachment" "test" {
  count = var.ec2_count
  target_group_arn = aws_lb_target_group.tg_web.arn
  target_id        = aws_instance.web_server[count.index].private_ip
  port             = 80
}
