resource "aws_eks_cluster" "example" {
  name     = "example"
  role_arn = arn:aws:iam::790543352839:role/eksClusterRole

  vpc_config {
    subnet_ids = [subnet-08f9e3975049119b3, subnet-0a02cc68894da7f97, subnet-0a4f88b69332464b6]
  }

output "endpoint" {
  value = aws_eks_cluster.example.endpoint
}

output "kubeconfig-certificate-authority-data" {
  value = aws_eks_cluster.example.certificate_authority[0].data
}
