resource "aws_cognito_user" "admin_user" {
  user_pool_id = aws_cognito_user_pool.main.id
  username     = "admin@example.com"

  attributes = {
    email = "admin@example.com"
  }

  force_alias_creation = false
  message_action       = "SUPPRESS"
  temporary_password   = "Admin123!"
}