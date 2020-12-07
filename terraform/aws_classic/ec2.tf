resource "aws_instance" "nginx_web_1" {
  ami                    = data.aws_ami.latest-ubuntu.id
  instance_type          = "t2.micro"
  key_name               = var.key_name
  subnet_id              = aws_subnet.nginx_subnet_1.id
  vpc_security_group_ids = [aws_security_group.nginx_sg.id]
  user_data = file("./script/install_nginx.sh")

  tags = {
    Name = "Nginx web server 1"
    Terraform = "true"
    Environment = "dev"
  }
}

resource "aws_instance" "nginx_web_2" {
  ami                    = data.aws_ami.latest-ubuntu.id
  instance_type          = "t2.micro"
  key_name               = var.key_name
  subnet_id              = aws_subnet.nginx_subnet_2.id
  vpc_security_group_ids = [aws_security_group.nginx_sg.id]
  user_data = file("./script/install_nginx.sh")

  tags = {
    Name = "Nginx web server 2"
    Terraform = "true"
    Environment = "dev"
  }
}