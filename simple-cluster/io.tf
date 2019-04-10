########################################################################################################################
# A Simple Redshift Cluster example
#
# Module Inputs & Outputs
########################################################################################################################

###########################################################
# Inputs
###########################################################

#############################
# Naming
#############################
variable "name" {
    description = "Name to be used for the resources"
}

#############################
# S3 Parameters
#############################
variable "bucket_acl" {
    description = "Policy for the S3 bucket. "
    default = "private"
}

#############################
# Redshift Paramters
#############################
variable "node_types" {
    description = "Node types to boot into the Redshift cluster.  See https://aws.amazon.com/Redshift/pricing/."
    default = "dc2.large"
}

variable "node_count" {
    description = "Number of nodes to run in the Red Shift cluster"
    default = "1"
}

variable "master_password" {
    description = "Redshift Master user name.  WARNING: This will leak (https://www.terraform.io/docs/providers/aws/r/redshift_cluster.html#master_password); change after creation"
}

variable "master_username" {
    description = "Redshift Master user name."
}

variable "node_sgs" {
    description = "Security Groups to attach to the node"
    type = "list"
    default = []
}

variable "final_snapshot" {
    description = "Boolean (take a final snapshot)"
    default = false
}


#############################
# Billing and Accounting
#############################
variable "cost_center" {
    description = "Cost center associated for the given resources"
}

variable "tags" {
    description = "Other tags to associate with the given resources"
    type = "map"
    default = {}
}

#############################
# Organizational Name
#############################
variable "org_prefix" {
    description = "Organziational Prefix"
    default = "me-example"
}

###########################################################
# Outputs
###########################################################

#############################
# Versioning
#############################
output "version" {
    value = "${local.version}"
}

#############################
# S3 Resources
#############################
output "bucket" {
    value = "${aws_s3_bucket.bucket.bucket}"
}

output "bucket_arn" {
    value = "${aws_s3_bucket.bucket.arn}"
}

#############################
# Redshift Resources
#############################
output "redshift_endpoint" {
    value = "${aws_redshift_cluster.simple_cluster.endpoint}"
}

output "redshift_s3_access" {
    value = "${aws_iam_role.simple_bucket_access.arn}"
}
