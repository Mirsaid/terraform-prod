resource "aws_vpc_endpoint" "s3" { #type "Gateway"
  vpc_id       = var.vpc_id
  service_name = "com.amazonaws.${var.region}.s3"
  
#   policy = <<POLICY
# {
#   "Statement": [{
#     "Action": "*",
#     "Effect": "Allow",
#     "Resource": "*",
#     "Principal": "*"
#   }]
# }
# POLICY
}

