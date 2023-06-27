variable "ec2_server_private_ip"{
  description = "The private IP of the EC2 server"
}
variable "ssh_user"{
    default = "ubuntu"
}

variable "private_key_path" {
    default = "dev-srv-key.pem"
}