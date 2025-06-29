resource "aws_eks_cluster" "eks-cluster" {
  name     = "${var.NOME}-eks"
  version  = "1.32"
  role_arn = data.aws_iam_role.labrole.arn

  vpc_config {
    subnet_ids         = [for idx, subnet in module.vpc.private_subnets : subnet if module.vpc.azs[idx] != "${var.regionDefault}e"]
    security_group_ids = [aws_security_group.sg.id]
  }

  access_config {
    authentication_mode = var.accessConfig
  }

  tags = {
    projeto = var.TAGS
  }
}

output "clusterName" {
  value = aws_eks_cluster.eks-cluster.name
}

data "aws_eks_cluster" "this" {
  name = aws_eks_cluster.eks-cluster.name
}

data "aws_eks_cluster_auth" "this" {
  name = aws_eks_cluster.eks-cluster.name
}
