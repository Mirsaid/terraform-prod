resource "aws_route_table" "private" {
  vpc_id = var.vpc_id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = var.nat_gw_id
  }

  tags = {
    Name = "private"
  }
}

resource "aws_route_table" "public" {
  vpc_id = var.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.igw_id
  }

  tags = {
    Name = "public"
  }
}

resource "aws_route_table_association" "private_subnet_1a_ec2_id" {
  subnet_id      = var.private_subnet_1a_ec2_id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "private_us_east_1a_rds_id" {
  subnet_id      = var.private_eu_central_1a_rds_id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "private_us_east_1b_rds_id" {
  subnet_id      = var.private_eu_central_1b_rds_id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "public_us_east_1a" {
  subnet_id      = var.public_subnet_1a_id
  route_table_id = aws_route_table.public.id
}

resource "aws_vpc_endpoint_route_table_association" "private_sub_endpoint_gw" {
  route_table_id  = aws_route_table.private.id
  vpc_endpoint_id = var.vpc_endpoint_id
}

# resource "aws_route_table_association" "public_us_east_1b" {
#   subnet_id      = var.public_subnet_1b_id
#   route_table_id = aws_route_table.public.id
# }