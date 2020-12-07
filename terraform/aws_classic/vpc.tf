resource "aws_vpc" "nginx_vpc" {
  cidr_block       = "10.0.0.0/16"
  enable_dns_support = true
  enable_dns_hostnames = true
  
  tags = {
    Name = "Nginx VPC"
    Terraform = "true"
    Environment = "dev"
  }
}

resource "aws_subnet" "nginx_subnet_1" {
    vpc_id = aws_vpc.nginx_vpc.id
    cidr_block = "10.0.1.0/24"
    map_public_ip_on_launch = "true"
    availability_zone = data.aws_availability_zones.available.names[0]
    tags = {
      Name = "nginx_subnet_1"
      Terraform = "true"
      Environment = "dev"
    }
}

resource "aws_subnet" "nginx_subnet_2" {
    vpc_id = aws_vpc.nginx_vpc.id
    cidr_block = "10.0.2.0/24"
    map_public_ip_on_launch = "true"
    availability_zone = data.aws_availability_zones.available.names[1]
    tags = {
      Name = "nginx_subnet_2"
      Terraform = "true"
      Environment = "dev"
    }
}