data "aws_ami" "latest-ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"] # or "*ubuntu-bionic-18.04-amd64-server-*"
  }
}

data "aws_availability_zones" "available" {
  state = "available"
}
