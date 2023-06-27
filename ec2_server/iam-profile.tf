resource "aws_iam_instance_profile" "ec2_profile" {                            
    name  = "ec2profile"                         
    role = var.ec2_s3_access_role
}
