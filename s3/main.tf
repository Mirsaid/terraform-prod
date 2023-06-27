resource "aws_s3_bucket" "bucket" {
  bucket = var.bucket_name

  tags = {
    Name        = "test-bucket"
    Environment = "VPC_EndPoint_test"
  }
}

#212.8.253.139

resource "aws_s3_bucket_policy" "s3_access_policy" {
  bucket = var.bucket_name  
depends_on = [aws_s3_bucket.bucket] 
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "IPAllow",
      "Effect": "Allow",
      "Principal": "*",
      "Action": "s3:GetObject",
      "Resource": [
                "arn:aws:s3:::${var.bucket_name}",
                "arn:aws:s3:::${var.bucket_name}/*"
            ],
      "Condition": {
        "IpAddress": {
          "aws:SourceIp": "87.138.105.2/32"
        }
      }
    }
  ]
}
EOF
}

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