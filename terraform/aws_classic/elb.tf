resource "aws_elb" "nginx_elb" {
  name                        = "nginx-webserver-lb"
  instances                   = [aws_instance.nginx_web_1.id, aws_instance.nginx_web_2.id]
  subnets                     = [aws_subnet.nginx_subnet_1.id, aws_subnet.nginx_subnet_2.id]
  security_groups             = [aws_security_group.nginx_sg.id]
  cross_zone_load_balancing   = true
  idle_timeout                = 400
  connection_draining         = true
  connection_draining_timeout = 400

  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:80/"
    interval            = 30
  }

  tags = {
    Name        = "Nginx webserver load balancer"
    Terraform   = "true"
    Environment = "dev"
  }
}
