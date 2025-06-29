



# User Pool
resource "aws_cognito_user_pool" "main" {
  name = "${var.NOME}-user-pool"

  username_attributes = ["email"]
  auto_verified_attributes = ["email"]

  password_policy {
    minimum_length    = 8
    require_lowercase = true
    require_uppercase = true
    require_numbers   = true
    require_symbols   = false
  }

  account_recovery_setting {
    recovery_mechanism {
      name     = "verified_email"
      priority = 1
    }
  }

   admin_create_user_config {
    allow_admin_create_user_only = false
    
  }

 
}

# User Pool Domain (necessário para OAuth)
resource "aws_cognito_user_pool_domain" "app_client_domain" {
  domain       = "${var.NOME}-domain"
  user_pool_id = aws_cognito_user_pool.main.id
}

# App Client (sem secret, compatível com fluxo USER_PASSWORD_AUTH)
resource "aws_cognito_user_pool_client" "web_client" {
  name         = "${var.NOME}-web-client"
  user_pool_id = aws_cognito_user_pool.main.id

  # OAuth 2.0 configuration
  generate_secret            = false
  allowed_oauth_flows_user_pool_client = true
  allowed_oauth_flows                  = ["code", "implicit"]
  allowed_oauth_scopes                = ["email", "openid", "profile", "aws.cognito.signin.user.admin"]

  callback_urls = [
    "http://localhost:8080/callback",       # para testes locais
    "https://meusite.com/callback"          # produção, se tiver
  ]

  logout_urls = [
    "http://localhost:8080/logout",
    "https://meusite.com/logout"
  ]

  # Configurações de token
  access_token_validity  = 1    # 1 hora
  id_token_validity     = 1    # 1 hora  
  refresh_token_validity = 30   # 30 dias

  token_validity_units {
    access_token  = "hours"
    id_token     = "hours"
    refresh_token = "days"
  }

  supported_identity_providers = ["COGNITO"]

  explicit_auth_flows = [
    "ALLOW_USER_SRP_AUTH",
    "ALLOW_REFRESH_TOKEN_AUTH",
    "ALLOW_USER_PASSWORD_AUTH"
  ]

  prevent_user_existence_errors = "ENABLED"
}

# Cognito User Pool Client para aplicação mobile/server
resource "aws_cognito_user_pool_client" "mobile_client" {
  name         = "${var.NOME}-user-pool-mobile-client"
  user_pool_id = aws_cognito_user_pool.main.id

  # OAuth 2.0 configuration para mobile
  generate_secret                      = true   # Para aplicações server-side
   allowed_oauth_flows                  = ["code"]
  allowed_oauth_flows_user_pool_client = true
  allowed_oauth_scopes                 = ["email", "openid", "profile"]
  
  # URLs específicas para mobile
  callback_urls = [
    "http://localhost:8080/callback",       # para testes locais
    "https://meusite.com/callback"          # produção, se tiver
  ]

  logout_urls = [
    "http://localhost:8080/logout",
    "https://meusite.com/logout"
  ]

  # Configurações de token para mobile
  access_token_validity  = 1    # 1 hora
  id_token_validity     = 1    # 1 hora  
  refresh_token_validity = 30   # 30 dias
  
  token_validity_units {
    access_token  = "hours"
    id_token     = "hours"
    refresh_token = "days"
  }


  # Fluxos de autenticação para mobile
  explicit_auth_flows = [
    "ALLOW_USER_SRP_AUTH",
    "ALLOW_REFRESH_TOKEN_AUTH"
  ]

  prevent_user_existence_errors = "ENABLED"
}

# Identity Pool (opcional, para acesso a recursos AWS)
resource "aws_cognito_identity_pool" "main" {
  identity_pool_name               = "${var.NOME}-identity-pool"
  allow_unauthenticated_identities = false

  cognito_identity_providers {
    client_id     = aws_cognito_user_pool_client.web_client.id
    provider_name = aws_cognito_user_pool.main.endpoint
  }

}


