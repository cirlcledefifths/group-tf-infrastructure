# Create the API Gateway
resource "aws_apigatewayv2_api" "associations"  {
  name        = "mod-associations-api"
  description = "Associations REST API Gateway"
  protocol_type = "HTTP"
}

# Create dev
resource "aws_apigatewayv2_stage" "dev" {
  api_id        = aws_apigatewayv2_api.associations.id
  name          = "associations-api-stage-dev"
}

# Create qa
resource "aws_apigatewayv2_stage" "qa" {
  api_id        = aws_apigatewayv2_api.associations.id
  name          = "associations-api-stage-dqa"
}

# # Create staging
resource "aws_apigatewayv2_stage" "staging" {
  api_id        = aws_apigatewayv2_api.associations.id
  name          = "associations-api-stage-staging"
}

# Optional: Add logging for API Gateway
resource "duplocloud_api_gateway_method_settings" "this" {
  rest_api_id = duplocloud_api_gateway_rest_api.this.id
  stage_name  = duplocloud_api_gateway_stage.this.stage_name
  method_path = "*/*"

  settings {
    metrics_enabled = true
    logging_level   = "INFO"
  }
}

output "dev_invoke_url" {
  value = "${duplocloud_api_gateway_dev_stage.this.invoke_url}/"
}

output "staging_invoke_url" {
  value = "${duplocloud_api_gateway_staging_stage.this.invoke_url}/"
}
