########################################################################################################################
# Redshift Cluster Example
#
# Internal Data and Locals
########################################################################################################################

###########################################################
# Name Related
###########################################################
locals {
  name = "${var.org_prefix}-${var.name}"
  tags = "${merge(var.tags, map("cost_center", var.cost_center))}"
}

###########################################################
# Extractions from the provider
###########################################################
data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

locals {
  region = "${data.aws_region.current.name}"
  account_id = "${data.aws_caller_identity.current.account_id}"
}

###########################################################
# Versioning
###########################################################
locals {
  version = "0.1.0"
}