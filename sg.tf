provider "aws" {
  region = "eu-central-1"  # Specify your desired AWS region
}

resource "aws_emrcontainers_virtual_cluster" "example" {
  container_provider {
    id   = test
    type = "EKS"

    info {
      eks_info {
        namespace = "default"
      }
    }
  }

  name = "example"
}


