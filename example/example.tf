
module "rs" {
  source = "../simple-cluster"
  name = "example-${random_id.id.hex}"
  cost_center = "interview"

  master_username = "interview"
  master_password = "Bad$Example-Password19"
  node_sgs = ["${aws_security_group.redshift_group.id}"]
}

provider "aws" {
  region = "us-west-2"
}

resource "random_id" "id" {
  byte_length = 2
}

resource "aws_security_group" "redshift_group" {
  name = "interview-rs-test-${random_id.id.hex}"
  description = "SG for Redshift access"

  ingress {
    from_port = 5439
    protocol = "TCP"
    to_port = 5439
    cidr_blocks = ["0.0.0.0/0"]
  }
}

output "redshift_s3_access" {
  value = "${module.rs.redshift_s3_access}"
}
output "redshift_endpoint" {
  value = "${module.rs.redshift_endpoint}"
}
output "s3_bucket" {
  value = "${module.rs.bucket}"
}

# Normally we would use S3 state and such...but this is an example ;-)
