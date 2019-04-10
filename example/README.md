# Example application of Simple Redshift Cluster

This is an example application of the Simple Redshift cluster.  To apply this ensure your AWS profile is properly setup
or defaulted, then execute the following:

```bash
terraform init
terraform plan --parallelism=32 -out .plan
# Iterate on teh change set until you are comfortable
terraform apply --parallelism=32 .plan
```

This will result in the following outputs:
* `redshift_endpoint` - The address of the Redshift cluster
* `redshift_s3_access` - IAM role to use when accessing
the bucket.
* `s3_bucket` - The name of the S3 bucket.
