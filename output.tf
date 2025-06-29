output "user_pool_id" {
  description = "ID do User Pool"
  value       = aws_cognito_user_pool.main.id
}

output "user_pool_arn" {
  description = "ARN do User Pool"
  value       = aws_cognito_user_pool.main.arn
}

output "user_pool_endpoint" {
  description = "Endpoint do User Pool"
  value       = aws_cognito_user_pool.main.endpoint
}

output "web_client_id" {
  description = "ID do cliente web"
  value       = aws_cognito_user_pool_client.web_client.id
}

output "mobile_client_id" {
  description = "ID do cliente mobile"
  value       = aws_cognito_user_pool_client.mobile_client.id
}

output "mobile_client_secret" {
  description = "Secret do cliente mobile"
  value       = aws_cognito_user_pool_client.mobile_client.client_secret
  sensitive   = true
}

output "identity_pool_id" {
  description = "ID do Identity Pool"
  value       = aws_cognito_identity_pool.main.id
}

output "cognito_domain" {
  description = "Domínio do Cognito"
  value       = aws_cognito_user_pool_domain.app_client_domain.domain
}

output "hosted_ui_url" {
  description = "URL da interface hospedada do Cognito"
  value       = "https://${aws_cognito_user_pool_domain.app_client_domain.domain}.auth.${var.regionDefault}.amazoncognito.com"
}

output "oauth_endpoints" {
  description = "Endpoints OAuth 2.0"
  value = {
    authorization = "https://${aws_cognito_user_pool_domain.app_client_domain.domain}.auth.${var.regionDefault}.amazoncognito.com/oauth2/authorize"
    token        = "https://${aws_cognito_user_pool_domain.app_client_domain.domain}.auth.${var.regionDefault}.amazoncognito.com/oauth2/token"
    userinfo     = "https://${aws_cognito_user_pool_domain.app_client_domain.domain}.auth.${var.regionDefault}.amazoncognito.com/oauth2/userInfo"
  }
}



output "client_id" {
  value = aws_cognito_user_pool_client.web_client.id
}

output "user_pool_domain" {
  value = aws_cognito_user_pool_domain.app_client_domain.domain
}
