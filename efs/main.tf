resource "aws_efs_file_system" "matlab_runtime" {
  tags = {
    Name = "efs-matlab-runtime"
  }
}

resource "aws_efs_mount_target" "matlab_runtime" {
  file_system_id  = aws_efs_file_system.matlab_runtime.id
  subnet_id       = var.private_subnet_1a_ec2_id
  security_groups = [var.efs_sg_id]
}
