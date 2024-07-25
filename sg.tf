provider "aws" {
  region = "eu-central-1"  # Specify your desired AWS region
}

resource "aws_emrcontainers_virtual_cluster" "example" {
  container_provider {
    id   = aws_eks_cluster.example.name
    type = "EKS"

    info {
      eks_info {
        namespace = "default"
      }
    }
  }

  name = "example"
}


