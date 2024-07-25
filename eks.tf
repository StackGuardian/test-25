provider "aws" {
  region = "eu-central-1"  # Specify your desired AWS region
}

# Create a new VPC for EKS cluster
resource "aws_vpc" "eks_vpc" {
  cidr_block = "10.0.0.0/16"
  enable_dns_hostnames = true
}

# Create an Internet Gateway for the VPC
resource "aws_internet_gateway" "eks_igw" {
  vpc_id = aws_vpc.eks_vpc.id
}

# Create a subnet for EKS
resource "aws_subnet" "eks_subnet" {
  vpc_id     = aws_vpc.eks_vpc.id
  cidr_block = "10.0.1.0/24"
}

# Create an EKS cluster
module "eks_cluster" {
  source  = "terraform-aws-modules/eks/aws"
  version = "17.1.0"

  cluster_name    = "my-eks-cluster"
  cluster_version = "1.21"
  role_arn = arn:aws:iam::790543352839:role/eksClusterRole

  vpc_id     = aws_vpc.eks_vpc.id
  subnet_ids = [aws_subnet.eks_subnet.id]

  node_groups = {
    eks_nodes = {
      desired_capacity = 2
      max_capacity     = 2
      min_capacity     = 1

      instance_type = "t3.medium"
    }
  }

  tags = {
    Environment = "Development"
    Owner       = "Terraform"
  }
}

output "kubeconfig" {
  value = module.eks_cluster.kubeconfig
}
