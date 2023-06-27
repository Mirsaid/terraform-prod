output "nat_gw_id" {
  value = aws_nat_gateway.nat.id
}

output "eip_ip" {
  value = aws_eip.nat.public_ip
}