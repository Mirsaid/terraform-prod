output "bastion_sg_id" {
  value = aws_security_group.bastion_sg.id
}
output "ec2_sg_id" {
  value = aws_security_group.ec2_sg.id
}

output "efs_sg_id" {
  value = aws_security_group.efs_sg.id
}

output "rds_sg_id" {
  value = aws_security_group.rds_sg.id
}