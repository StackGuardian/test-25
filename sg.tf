provider "aws" {
  region = "eu-central-1"  # Specify your desired AWS region
}

resource "aws_redshift_cluster" "example_cluster" {
  cluster_identifier      = "example-cluster"
  database_name           = "mydatabase"
  master_username         = "admin"
  master_password         = "MySuperSecretPassword123" 

  node_type               = "dc2.large"
  cluster_type            = "single-node"  # 

  # AWS Redshift cluster parameters
  cluster_parameter_group_name = "default.redshift-1.0"
  cluster_subnet_group_name    = "subnet-0adeb216161049cca"  # Ensure this subnet group exists

  # VPC security group IDs
  vpc_security_group_ids = [
    "sg-0493c12ed4545a123"  # Replace with your own security group IDs
  ]

  # IAM roles (optional)
  iam_roles = [
    "arn:aws:iam::790543352839:role/aws-service-role/redshift.amazonaws.com/AWSServiceRoleForRedshift"  # Replace with your IAM role ARN if needed
  ]

  # Cluster encryption (optional)
  encrypted = false  # Set to true for encrypted clusters

  # Snapshot configuration (optional)
  skip_final_snapshot = false  # Set to false if you want a final snapshot

  # Tags (optional)
  tags = {
    Environment = "Development"
    Owner       = "Terraform"
  }
}
