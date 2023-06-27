#Assume Role Policy for EC2->S3 access
resource "aws_iam_role" "ec2_s3_access_role" {
  name               = "ec2_s3"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}
#Assume Policy for Role to access S3
resource "aws_iam_policy" "ec2_s3_policy" {
  name        = "ec2_S3_policy"
  description = "Access to s3 policy from ec2"
  policy      = <<EOF
{
 "Version": "2012-10-17",
   "Statement": [
       {
           "Effect": "Allow",
           "Action": "s3:*",
           "Resource": "*"
       }
    ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "ec2_attach_policy" {
  role     = aws_iam_role.ec2_s3_access_role.name
  policy_arn = aws_iam_policy.ec2_s3_policy.arn
}

#===================================================================================================#

/* Assume Role Policy for Backups */
data "aws_iam_policy_document" "example-aws-backup-service-assume-role-policy-doc" {
  statement {
    sid     = "AssumeServiceRole"
    actions = ["sts:AssumeRole"]
    effect  = "Allow"

    principals {
      type        = "Service"
      identifiers = ["backup.amazonaws.com"]
    }
  }
}

/* The policies that allow the backup service to take backups and restores */
data "aws_iam_policy" "aws-backup-service-policy" {
  arn = "arn:aws:iam::aws:policy/service-role/AWSBackupServiceRolePolicyForBackup"
}

data "aws_iam_policy" "aws-restore-service-policy" {
  arn = "arn:aws:iam::aws:policy/service-role/AWSBackupServiceRolePolicyForRestores"
}

data "aws_caller_identity" "current_account" {}

/* Needed to allow the backup service to restore from a snapshot to an EC2 instance
 See https://stackoverflow.com/questions/61802628/aws-backup-missing-permission-iampassrole */
data "aws_iam_policy_document" "example-pass-role-policy-doc" {
  statement {
    sid       = "ExamplePassRole"
    actions   = ["iam:PassRole"]
    effect    = "Allow"
    resources = ["arn:aws:iam::${data.aws_caller_identity.current_account.account_id}:role/*"]
  }
}

/* Roles for taking AWS Backups */
resource "aws_iam_role" "example-aws-backup-service-role" {
  name               = "ExampleAWSBackupServiceRole"
  description        = "Allows the AWS Backup Service to take scheduled backups"
  assume_role_policy = data.aws_iam_policy_document.example-aws-backup-service-assume-role-policy-doc.json

  tags = {
    Service = "AWS Backup"
    Role    = "iam"
  }
}

resource "aws_iam_role_policy" "example-backup-service-aws-backup-role-policy" {
  policy = data.aws_iam_policy.aws-backup-service-policy.policy
  role   = aws_iam_role.example-aws-backup-service-role.name
}

  # resource "aws_iam_role_policy" "example-restore-service-aws-backup-role-policy" {
  #   policy = data.aws_iam_policy.aws-restore-service-policy.policy
  #   role   = aws_iam_role.example-aws-backup-service-role.name
  # }

resource "aws_iam_role_policy" "example-backup-service-pass-role-policy" {
  policy = data.aws_iam_policy_document.example-pass-role-policy-doc.json
  role   = aws_iam_role.example-aws-backup-service-role.name
}

