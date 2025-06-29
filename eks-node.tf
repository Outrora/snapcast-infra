resource "aws_eks_node_group" "eks-node" {
  cluster_name    = aws_eks_cluster.eks-cluster.name
  node_group_name = var.NOME
  node_role_arn   = data.aws_iam_role.labrole.arn
  subnet_ids      = [for idx, subnet in module.vpc.private_subnets : subnet if module.vpc.azs[idx] != "${var.regionDefault}e"]
  disk_size       = 50
  instance_types  = [var.instanceType]
  

  scaling_config {
    desired_size = 2
    min_size     = 1
    max_size     = 3
  }

  update_config {
    max_unavailable = 1
  }

  tags = {
    projeto = var.TAGS
  }
}