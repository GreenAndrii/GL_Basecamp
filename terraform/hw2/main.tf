# k3s default infrastucture
/*
- add VPC
- add subnet
- add SG
+ add k3s_master
+ add k3s_worker(s)
*/

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
    values = ["*ubuntu-focal-20.04-amd64-server-*"] # or "*ubuntu-bionic-18.04-amd64-server-*"
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

module "k3s_master" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 2.0"

  name                   = "k3s_master"
  instance_count         = 1
  # ami                  = "ami-0c960b947cbb2dd16" # Ubuntu
  ami                    = data.aws_ami.latest-ubuntu.id
  instance_type          = "t2.micro"
  key_name               = var.key_name
  subnet_id              = tolist(data.aws_subnet_ids.all.ids)[0]
  vpc_security_group_ids = ["sg-021bfd8e5a5d21433"]
  tags = {
    Terraform   = "true"
    Environment = "k3s"
  }
}

module "k3s_worker" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 2.0"
  depends_on = [module.k3s_master]

  name           = "k3s_worker"
  instance_count = var.instance_count
  # ami                  = "ami-0c960b947cbb2dd16" # Ubuntu
  ami                    = data.aws_ami.latest-ubuntu.id
  instance_type          = "t2.micro"
  key_name               = var.key_name
  subnet_id              = tolist(data.aws_subnet_ids.all.ids)[0]
  vpc_security_group_ids = ["sg-021bfd8e5a5d21433"]
  tags = {
    Terraform   = "true"
    Environment = "k3s"
  }
}
