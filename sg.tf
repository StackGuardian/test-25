provider "aws" {
  region = "eu-central-1"  # Specify your desired AWS region
}

resource "aws_emr_cluster" "example_cluster" {
  name          = "example-emr-cluster"
  release_label = "emr-6.5.0"  # Specify the EMR version you want to use
  applications  = ["Spark", "Hadoop", "Hive", "Livy"]  # List of applications to be installed

  service_role  = "AWSServiceRoleForEMRCleanup"  # Ensure this role exists
  job_flow_role = "ec2-qa"  # Ensure this role exists

  instance_group {
    instance_role    = "MASTER"
    instance_type    = "m5.xlarge"
    instance_count   = 1
    name             = "Master Instance Group"
  }

  instance_group {
    instance_role    = "CORE"
    instance_type    = "m5.xlarge"
    instance_count   = 2
    name             = "Core Instance Group"
  }

  configurations_json = <<EOF
  [
    {
      "Classification": "spark",
      "Properties": {
        "maximizeResourceAllocation": "true"
      }
    }
  ]
  EOF

  bootstrap_action {
    name = "Install Example Package"
    path = "s3://your-bucket/bootstrap/install-example.sh"
    args = ["arg1", "arg2"]
  }

  tags = {
    Environment = "Development"
    Owner       = "Terraform"
  }
}
