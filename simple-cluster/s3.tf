########################################################################################################################
# Private S3 Bucket
#
# Module Inputs & Outputs
########################################################################################################################

###########################################################
# Primary Bucket resources
###########################################################

#############################
# Naming
#############################
resource "aws_s3_bucket" "bucket" {
  bucket = "${local.name}"
  acl = "${var.bucket_acl}"

  tags = "${local.tags}"
}

#############################
# Policies
#############################
resource "aws_iam_policy" "policy" {
  name_prefix = "${local.name}-bucket-rw"
  description = "Allows read & write access to the S3 bucket ${aws_s3_bucket.bucket.bucket} (v${local.version})"
  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": ["s3:ListBucket"],
      "Resource": ["${aws_s3_bucket.bucket.arn}"]
    },
    {
      "Effect": "Allow",
      "Action": [
        "s3:PutObject",
        "s3:GetObject",
        "s3:DeleteObject"
      ],
      "Resource": ["${aws_s3_bucket.bucket.arn}/*"]
    }
  ]
}
POLICY
}
