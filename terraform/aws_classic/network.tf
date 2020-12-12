resource "aws_route" "nginx_igw_route" {
  route_table_id         = aws_vpc.nginx_vpc.main_route_table_id
  destination_cidr_block = var.destinationCIDRblock
  gateway_id             = aws_internet_gateway.nginx-igw.id
}

resource "aws_internet_gateway" "nginx-igw" {
  vpc_id = aws_vpc.nginx_vpc.id

  tags = {
    Name        = "Nginx internet gateway"
    Terraform   = "true"
    Environment = "dev"
  }
}

resource "aws_security_group" "nginx_sg" {
  name   = "Nginx webserver security group"
  vpc_id = aws_vpc.nginx_vpc.id

  dynamic "ingress" {
    for_each = ["22", "80"]
    content {
      cidr_blocks = [var.destinationCIDRblock]
      from_port   = ingress.value
      protocol    = "tcp"
      to_port     = ingress.value
    }
  }

  egress {
    cidr_blocks = [var.destinationCIDRblock]
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
  }

  tags = {
    Name        = "Nginx security group"
    Terraform   = "true"
    Environment = "dev"
  }
}
