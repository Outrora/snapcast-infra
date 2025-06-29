resource "kubernetes_secret" "cognito" {
  metadata {
    name      = "cognito"
    namespace = "default"
  }

  data = {
    client_id = base64encode(aws_cognito_user_pool_client.web_client.id)
    user_pool_id = base64encode(aws_cognito_user_pool.main.id)
    domain = base64encode(aws_cognito_user_pool_domain.app_client_domain.domain)
  }

  type = "Opaque"
}

resource "kubernetes_secret" "db_credentials" {
  metadata {
    name      = "db-credentials"
    namespace = "default"
  }

  data = {
    db_user = base64encode(var.user)
    db_password = base64encode(var.senha)
    db_name = base64encode(var.NOME)
    db_endpoint = base64encode("jdbc:postgresql://${aws_db_instance.snapcast-db.address}:5432/${var.NOME}")
    db_kind = base64encode("postgresql")
  }

  type = "Opaque"
}

resource "kubernetes_secret" "bucket" {
  metadata {
    name      = "bucket"
    namespace = "default"
  }

  data = {
    name = base64encode(aws_s3_bucket.bucket_snapcast.bucket)
  }

  type = "Opaque"
}
