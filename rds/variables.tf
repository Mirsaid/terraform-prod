variable "vpc_id" {
  description = "The VPC ID"
}

variable "private_eu_central_1a_rds_id" {
  description = "The RDS private subnet ID"
}

variable "private_eu_central_1b_rds_id" {
  description = "The RDS private subnet az2 ID"
}

variable "rds_subnet_group_id" {
  description = "The RDS  subnet group name"
}

variable "rds_sg_id" {
  description = "The RDS security group ID"
}

variable "DB_USERNAME" {
  default = "myuser"
}
variable "DB_PASSWORD" {
  default = "mypassword"
}
variable "DB_NAME" {
  default = "mydb"
}


