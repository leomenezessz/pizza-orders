resource "aws_cognito_user_pool" "orders" {
  name = "OrdersPool"
}

resource "aws_cognito_resource_server" "resource" {
  identifier = "orders-app"
  name       = "orders-app"

  scope {
    scope_name        = "read_orders"
    scope_description = "Retrive Orders"
  }

  user_pool_id = aws_cognito_user_pool.orders.id
}

resource "aws_cognito_user_pool_client" "client" {
  name                                 = "client"
  user_pool_id                         = aws_cognito_user_pool.orders.id
  generate_secret                      = true
  allowed_oauth_flows_user_pool_client = true
  allowed_oauth_flows                  = ["client_credentials"]
  allowed_oauth_scopes                 = aws_cognito_resource_server.resource.scope_identifiers
}

resource "aws_cognito_user_pool_domain" "main" {
  domain       = "orders-pool-domain"
  user_pool_id = aws_cognito_user_pool.orders.id
}

