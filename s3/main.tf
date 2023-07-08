resource "aws_s3_bucket" "bucket" {
  bucket = var.bucket_name

  tags = {
    Name        = "test-bucket"
    Environment = "VPC_EndPoint_test"
  }
}

resource "aws_s3_object" "customer1_folder" {
    depends_on = [aws_s3_bucket.bucket]
    bucket   = var.bucket_name
    acl      = "private"
    key      =  "/home/customer1/"
    content_type = "application/x-directory"
    }
resource "aws_s3_object" "customer2_folder" {
    depends_on = [aws_s3_bucket.bucket]
    bucket   = var.bucket_name
    acl      = "private"
    key      =  "home/customer2/"
    content_type = "application/x-directory"
    }

    resource "aws_s3_object" "customer3_folder" {
    depends_on = [aws_s3_bucket.bucket]
    bucket   = var.bucket_name
    acl      = "private"
    key      =  "/home/customer3/"
    content_type = "application/x-directory"
    }

# resource "aws_s3_bucket_policy" "s3_access_policy" {
#   bucket     = var.bucket_name
#   depends_on = [aws_s3_bucket.bucket]
#   policy     = <<EOF
# {
#   "Version": "2012-10-17",
#   "Statement": [
#     {
#       "Sid": "IPAllow",
#       "Effect": "Allow",
#       "Principal": "*",
#       "Action": "s3:*",
#       "Resource": [
#                 "arn:aws:s3:::${var.bucket_name}",
#                 "arn:aws:s3:::${var.bucket_name}/*"
#             ],
#       "Condition": {
#         "IpAddress": {
#           "aws:SourceIp": [ "87.138.105.2/32", 
#                             "88.128.92.9/32",
#                             "212.51.10.78/32",
#                             "185.103.225.164/32" ]
#         }
#       }
#     }
#   ]
# }
# EOF
# }

# resource "aws_s3_bucket_acl" "bucket_acl" {
#   bucket = aws_s3_bucket.bucket.id
#   acl    = "private"
# }




# {
#     "Version": "2012-10-17",
#     "Id": "S3PolicyId1",
#     "Statement": [
#         {
#             "Sid": "IPAllow",
#             "Effect": "Deny",
#             "Principal": "*",
#             "Action": "s3:*",
#             "Resource": [
#                 "arn:aws:s3:::DOC-EXAMPLE-BUCKET",
#                 "arn:aws:s3:::DOC-EXAMPLE-BUCKET/*"
#             ],
#             "Condition": {
#                 "NotIpAddress": {
#                     "aws:SourceIp": "192.0.2.0/24"
#                 }
#             }
#         }
#     ]
# }