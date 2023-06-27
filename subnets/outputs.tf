output "private_subnet_1a_ec2_id" {
  value = aws_subnet.private_eu_central_1a_ec2.id
}

output "private_eu_central_1a_rds_id" {
  value = aws_subnet.private_eu_central_1a_rds.id
}

output "private_eu_central_1b_rds_id" {
  value = aws_subnet.private_eu_central_1b_rds.id
}


output "rds_subnet_group_id" {
  value = aws_db_subnet_group.rds_subnet_group.id
}


output "public_subnet_1a_id" {
  value = aws_subnet.public_eu_central_1a.id
}

# output "private_subnet_1b_id" {
#   value = aws_subnet.private_us_east_1b.id
# }
# output "public_subnet_1b_id" {
#   value = aws_subnet.public_us_east_1b.id
# }
