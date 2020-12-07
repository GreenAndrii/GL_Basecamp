variable "region" {
  default = "us-west-1"
}

variable "key_name" {
  description = "Name of key pair"
  default     = "basecamp_us_west_1"
}

variable "ssh_user" {
  description = "SSH user name to connect to your instance."
  default     = "ubuntu"
}

variable "instance_count" {
  default = "2"
}

variable "destinationCIDRblock" {
  default = "0.0.0.0/0"
}
