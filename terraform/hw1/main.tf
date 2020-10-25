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

module "ec2" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 2.0"

  name           = "hw1_stack"
  instance_count = 4
  # ami                  = "ami-04932daa2567651e7" # Ubuntu
  ami                    = data.aws_ami.latest-ubuntu.id
  instance_type          = "t2.micro"
  key_name               = var.key_name
  subnet_id              = tolist(data.aws_subnet_ids.all.ids)[0]
  vpc_security_group_ids = ["sg-021bfd8e5a5d21433"]

  # user_data = "curl https://ipv4.cloudns.net/api/dynamicURL/?q=MjkwMTQ1MDoyMDk4MTc1NzQ6MTE1ZDg4NDVlYTYzYTU4NmU4NzI5MDMxMjBiNmU5NjU1ZGY1YmI5ZDA5NGQ1OTM5NTA3NjZiN2FlMjlkNWRlOA"


  tags = {
    Terraform   = "true"
    Environment = "hw1"
  }
}

# module "flask_security_group"{
# 	source = "terraform-aws-modules/security-group/aws"

# 	name = "flask_aws_sg"
# 	description = "AWS security group for microblog Flask project"
# 	vpc_id = data.aws_vpc.default.id


# }

# module "http_sg" {
#   source = "../../modules/http-80"

#   name        = "http-sg"
#   description = "Security group with HTTP ports open for everybody (IPv4 CIDR), egress ports are all world open"
#   vpc_id      = data.aws_vpc.default.id

#   ingress_cidr_blocks = ["0.0.0.0/0"]
# }

# generate Ansible hosts file
resource "local_file" "hosts" {
  content = templatefile("${path.module}/templates/inventory.tpl",
    {
      hw1_stack = module.ec2.public_ip
      ssh_user = var.ssh_user
      key_name = var.key_name
      count = length(module.ec2.public_ip)
    }
  )
  filename = "../../ansible/inventory.yml"
}

