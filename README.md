# Example Redshift Cluster + S3 Bucket

Contains an example of a Terraform module to manage a Redshift cluster and an S3 bucket.  As a result of this being an
example there were some liberties taken.  For example, on a secure network the Redshift cluster would be attached under
a set of subnets specific to the cluster.  The example module is not versioned under Git as would be expected via the
normal practice.

## Components

[simple-cluster](simple-cluster) is the example Terraform module.  This will create a Redshift cluster with an
associated S3 bucket, which it has access to.  Please see the [module readme](simple-cluster/README.md) for the required
parameters. 

[example](example) is an example application of the cluster module.

## Lessons Learned & Expierence
* Although I've worked around Redshift clusters, the Data Science & Data Platform (peer) groups have been responsible
for designing and implementing these.  As a result I am a bit surprised at the AWS native integrations to the Postgres
style, including IAM.
* I was surprised there is not an `arn` attribute on the Redshift Terraform Resource; I am interested in why and if this
is a point I might be able to contribute back to the AWS Terraform provider.
* I ran into [#3104](https://github.com/terraform-providers/terraform-provider-aws/issues/3104) which was a bit unfortunate.
* Feels like Redshift takes about as long as RDS to create & destroy.