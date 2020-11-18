provider "aws" {
  region = var.region

}

data "aws_vpc" "default" {
  default = true
}

data "aws_subnet_ids" "all" {
  vpc_id = data.aws_vpc.default.id
}

data "aws_ami" "latest-ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server.*"] # or "*ubuntu-bionic-18.04-amd64-server-*"
  }
}

module "ec2" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 2.0"

  name           = "hw1_stack"
  instance_count = var.instance_count
  # ami                  = "ami-04932daa2567651e7" # Ubuntu
  ami                    = data.aws_ami.latest-ubuntu.id
  instance_type          = "t2.micro"
  key_name               = var.key_name
  subnet_id              = tolist(data.aws_subnet_ids.all.ids)[0]
  vpc_security_group_ids = ["sg-021bfd8e5a5d21433"]

  tags = {
    Terraform   = "true"
    Environment = "hw1"
  }
}

# generate Ansible inventory file
resource "local_file" "inventory" {
  content = templatefile("${path.module}/templates/inventory.tpl",
    {
      hw1_stack = module.ec2.public_ip
      ssh_user = var.ssh_user
      key_name = var.key_name
      count = length(module.ec2.public_ip)
    }
  )
  directory_permission = "0755"
  file_permission      = "0644"
  filename = "../../ansible/inventory.yml"
}

