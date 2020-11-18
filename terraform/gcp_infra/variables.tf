variable "project_name" {
  description = "Name of your GCP project.  Example: ansible-terraform-218216"
  default     = "k3sdemo"
}

variable "ssh_user" {
  description = "SSH user name to connect to your instance."
  default     = "scarolan"
}
