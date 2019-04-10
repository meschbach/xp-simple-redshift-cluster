# Simple Redshift cluster with an S3 Bucket

Example application of the module:
```hcl-terraform
module "rs" {
  source = "../simple-cluster"
  name = "app"
  cost_center = "data-science"

  master_username = "bad"
  master_password = "Wolf$Who14"
  node_sgs = ["${aws_security_group.redshift_group.id}"]
}
```

To access the associated bucket one needs to use the `aws_iam_role` key to the credentials command, such as:
```sql
copy part from 's3://me-example-example-8f94/part-csv.tbl'
    iam_role 'arn:aws:iam::377984214781:role/me-example-example-8f94-rw20190410221540885300000002'
csv
    null as '\000'
```

## Inputs

* `name` - The name of hte cluster and bucket.
* `master_password` - Master password for the new Redshift cluster.  Please change this once the cluster is bootstrapped
as value maybe stored in [plain text in the state file](https://www.terraform.io/docs/providers/aws/r/redshift_cluster.html).
* `master_username` - Master user name for the new Redshift cluster.
* `cost_center` - Cost center to be attached to the resources created.  This will be tagged under `cost_center` on all 
resources supporting tags.

### Optional Inputs
* `bucket_acl` - (Default: `private`) Default access policy for the bucket. Must be one of the [canned ACLs](https://docs.aws.amazon.com/AmazonS3/latest/dev/acl-overview.html#canned-acl).
* `node_types` - (Default: `dc2.large`) Type of Redshift nodes to utilize
* `node_count` - (Default: `1`) The number of Redshift nodes to include in the cluster. 
* `node_sgs` - (Default: `[]`) A list of security groups to attach to the Redshift cluster.
* `tags` - (Default: `{}`) Additional tags to be added to resources supporting tags.
* `org_prefix` - (Default: `me-example`) Organizational prefix to be added to all resources supporting names.

## Outputs

* `version` - Version of the module.
* `bucket` - S3 bucket associated with the simple cluster
* `bucket_arn` - ARN of the S3 bucket
* `redshift_endpoint` - Address of the new Redshift cluster
* `redshift_s3_access` - IAM role to access the bucket from S3
