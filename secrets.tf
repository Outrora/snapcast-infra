resource "kubernetes_secret" "cognito" {
  metadata {
    name      = "cognito"
    namespace = "default"
  }

  data = {
    client_id = aws_cognito_user_pool_client.web_client.id
    user_pool_id = aws_cognito_user_pool.main.id
    domain = aws_cognito_user_pool_domain.app_client_domain.domain
  }

  type = "Opaque"

  depends_on = [aws_eks_node_group.eks-node]
}

resource "kubernetes_secret" "db_credentials" {
  metadata {
    name      = "db-credentials"
    namespace = "default"
  }

  data = {
    db_user = var.user
    db_password = var.senha
    db_name = var.NOME
    db_endpoint = "jdbc:postgresql://${aws_db_instance.snapcast-db.address}:5432/${var.NOME}"
    db_kind = "postgresql"
  }

  type = "Opaque"

  depends_on = [aws_eks_node_group.eks-node]
}

resource "kubernetes_secret" "bucket" {
  metadata {
    name      = "bucket"
    namespace = "default"
  }

  data = {
    name = aws_s3_bucket.bucket_snapcast.bucket
  }

  type = "Opaque"

  depends_on = [aws_eks_node_group.eks-node]
}
