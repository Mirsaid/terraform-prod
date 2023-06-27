resource "aws_subnet" "private_eu_central_1a_ec2" {
  vpc_id            = var.vpc_id
  cidr_block        = "10.0.1.0/24"
  availability_zone = var.az_1a
  map_public_ip_on_launch = "false" #this subnet will be publicy accessible if you do not explicity set this to false

  tags = {
    "Name" = "private_ec2"
  }
}

resource "aws_subnet" "private_eu_central_1a_rds" {
  vpc_id            = var.vpc_id
  cidr_block        = "10.0.2.0/24"
  availability_zone = var.az_1a
  map_public_ip_on_launch = "false"

  tags = {
    "Name" = "private_rds"
  }
}

resource "aws_subnet" "private_eu_central_1b_rds" {
  vpc_id            = var.vpc_id #Second subnet in different az for rds
  cidr_block        = "10.0.3.0/24"
  availability_zone = var.az_1b
  map_public_ip_on_launch = "false"

  tags = {
    "Name" = "private_rds"
  }
}
resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = "db_subnet_group"
  subnet_ids = [aws_subnet.private_eu_central_1a_rds.id, aws_subnet.private_eu_central_1b_rds.id] 
  }

resource "aws_subnet" "public_eu_central_1a" {
  vpc_id                  = var.vpc_id
  cidr_block              = "10.0.4.0/24"
  availability_zone       = var.az_1a
  map_public_ip_on_launch = true

  tags = {
    "Name" = "public_bastion"
  }
}

# resource "aws_subnet" "public_us_east_1b" {
#   vpc_id                  = var.vpc_id
#   cidr_block              = "10.0.4.0/24"
#   availability_zone       = "us-east-1b"
#   map_public_ip_on_launch = true

#   tags = {
#     "Name" = "public-us-east-1b"
#   }
# }

# resource "aws_subnet" "private_us_east_1b" {
#   vpc_id            = var.vpc_id
#   cidr_block        = "10.0.2.0/24"
#   availability_zone = "us-east-1b"

#   tags = {
#     "Name" = "private-us-east-1b"
#   }
# }

