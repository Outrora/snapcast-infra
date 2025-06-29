resource "aws_eks_access_entry" "eks-access-entry" {
  cluster_name      = aws_eks_cluster.eks-cluster.name
  principal_arn     = var.principalArn
  kubernetes_groups = ["fiap"]
  type              = "STANDARD"

  tags = {
    projeto = var.TAGS
  }
}

resource "aws_eks_access_policy_association" "admin" {
  cluster_name  = data.aws_eks_cluster.this.name
  principal_arn = var.principalArn
  policy_arn    = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
  access_scope {
    type = "cluster"
  }
}