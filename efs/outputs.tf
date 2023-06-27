output "efs_dns_name" {
    value = aws_efs_file_system.matlab_runtime.dns_name
}

# output "efs_mount_target_id" {
#     value = aws_efs_mount_target.matlab_runtime.id
# }