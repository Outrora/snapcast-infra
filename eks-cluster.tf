resource "aws_eks_cluster" "eks-cluster" {
  name     = "${var.NOME}-EKS"
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

resource "kubernetes_namespace" "eks_namespace" {
  metadata {
    name = "${var.NOME}-EKS"
  }
}

resource "aws_iam_openid_connect_provider" "eks" {
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = ["9e99a48a9960b14926bb7f3b02e22da0ecd4e4e4"] # Confirme o thumbprint correto para sua região/cluster
  url             = data.aws_eks_cluster.this.identity[0].oidc[0].issuer
}


resource "aws_iam_role" "irsa_role" {
   name = "eks-irsa-role"

  assume_role_policy  = jsonencode({
    Version = "2012-10-17",
    Statement: [
      {
        Effect: "Allow",
        Principal: {
          AWS = "${var.principalArn}"  # <-- seu PrincipalArn aqui
        },
        Action: "sts:AssumeRoleWithWebIdentity",

      }
    ]
  })
}

resource "kubernetes_service_account" "app_sa" {
  metadata {
    name      = "${var.NOME}-account" # Nome do Service Account
    namespace = kubernetes_namespace.eks_namespace.metadata[0].name
    annotations = {
      "eks.amazonaws.com/role-arn" = var.principalArn
    }
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
