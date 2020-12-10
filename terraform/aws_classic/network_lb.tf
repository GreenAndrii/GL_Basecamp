resource "aws_lb" "nginx_network_lb" {
  name                             = "nginx-network-lb"
  load_balancer_type               = "network"
  enable_cross_zone_load_balancing = true
  ip_address_type                  = "ipv4"
  subnets                          = [aws_subnet.nginx_subnet_1.id, aws_subnet.nginx_subnet_2.id]

  tags = {
    Name        = "Nginx webserver load balancer"
    Terraform   = "true"
    Environment = "dev"
  }
}

resource "aws_lb_target_group" "nginx_lb_tg" {
  name     = "nginx-lb-target-group"
  port     = 80
  protocol = "TCP"
  vpc_id   = aws_vpc.nginx_vpc.id

  health_check {
    protocol            = "HTTP"
    healthy_threshold   = 3
    unhealthy_threshold = 3
    path                = "/"
    interval            = 30
  }

  tags = {
  Name        = "Nginx target group for load balancer"
  Terraform   = "true"
  Environment = "dev"
}
}

resource "aws_lb_listener" "nginx_lb_listener" {
  load_balancer_arn = aws_lb.nginx_network_lb.arn
  port              = "80"
  protocol          = "TCP"
  
  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.nginx_lb_tg.id
  }
}

resource "aws_lb_target_group_attachment" "nging_targets_1" {
  target_group_arn = aws_lb_target_group.nginx_lb_tg.arn
  target_id        = aws_instance.nginx_web_1.id
  port             = 80
}

resource "aws_lb_target_group_attachment" "nging_targets_2" {
  target_group_arn = aws_lb_target_group.nginx_lb_tg.arn
  target_id        = aws_instance.nginx_web_2.id
  port             = 80
}
