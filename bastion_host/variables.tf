variable "vpc_id" {
  description = "The VPC ID"
}

variable "public_subnet_1a_id" {
  description = "The public subnet ID"
}

variable "bastion_sg_id" {
  description = "The bastion security group ID"
}

variable "key_name" {
  description = "The key name"
  default = "dev-srv-key"
}

variable "availability_zone" {
    default = "eu-central-1a"
}

variable "ec2_server_private_ip"{
  description = "The private IP of the EC2 server"
}

variable "ssh_user" {
    default = "ubuntu"
}

variable "private_key_path" {
    default = "dev-srv-key.pem"
}