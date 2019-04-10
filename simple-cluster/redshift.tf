########################################################################################################################
# Redshift Cluster Example
#
# Redshift Cluster Binding
########################################################################################################################

###########################################################
# Redshift Cluster
###########################################################

#############################
# Cluster Management
#############################
resource "aws_redshift_cluster" "simple_cluster" {
  cluster_identifier = "${local.name}"
  node_type = "${var.node_types}"
  number_of_nodes = "${var.node_count}"

  master_password = "${var.master_password}"
  master_username = "${var.master_username}"

  tags = "${local.tags}"
  vpc_security_group_ids = ["${var.node_sgs}"]
  iam_roles = ["${aws_iam_role.simple_bucket_access.arn}"]

  skip_final_snapshot = "${var.final_snapshot}"
}

#############################
# S3 Access Role
#############################
resource "aws_iam_role" "simple_bucket_access" {
  name_prefix = "${local.name}-rw"
  description = "Allows Redshift cluster '${local.name}' to access S3 bucket '${aws_s3_bucket.bucket.bucket}' (v${local.version})"
  tags = "${local.tags}"

  assume_role_policy = <<STS
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service":  "redshift.amazonaws.com"
      },
      "Action": "sts:AssumeRole",
      "Condition": {
        "StringEquals": {
          "sts:ExternalId": [
            "arn:aws:redshift:${local.region}:${local.account_id}:dbuser:${local.name}/${var.master_username}"
          ]
        }
      }
    }
  ]
}
STS
}

resource "aws_iam_role_policy_attachment" "simple_cluster_bucket" {
  policy_arn = "${aws_iam_policy.policy.arn}"
  role = "${aws_iam_role.simple_bucket_access.name}"
}
