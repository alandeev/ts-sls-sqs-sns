resource "aws_api_gateway_rest_api" "base_api" {
  name                    = "products"
}

resource "aws_api_gateway_resource" "products" {
  rest_api_id             = aws_api_gateway_rest_api.base_api.id
  parent_id               = aws_api_gateway_rest_api.base_api.root_resource_id
  path_part               = "products"
}

resource "aws_api_gateway_resource" "productId" {
  rest_api_id             = aws_api_gateway_rest_api.base_api.id
  parent_id               = aws_api_gateway_resource.products.id
  path_part               = "{id}"
}

resource "aws_api_gateway_method" "method_get_product" {
  rest_api_id             = aws_api_gateway_rest_api.base_api.id
  resource_id             = aws_api_gateway_resource.productId.id
  http_method             = "GET"
  authorization           = "NONE"
}

resource "aws_api_gateway_integration" "integration_get_product" {
  rest_api_id             = aws_api_gateway_rest_api.base_api.id
  resource_id             = aws_api_gateway_method.method_get_product.resource_id
  http_method             = aws_api_gateway_method.method_get_product.http_method

  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = module.lambda_get_product.invoke_arn
}

resource "aws_api_gateway_method" "method_remove_product" {
  rest_api_id             = aws_api_gateway_rest_api.base_api.id
  resource_id             = aws_api_gateway_resource.productId.id
  http_method             = "DELETE"
  authorization           = "NONE"
}

resource "aws_api_gateway_integration" "integration_remove_product" {
  rest_api_id             = aws_api_gateway_rest_api.base_api.id
  resource_id             = aws_api_gateway_method.method_remove_product.resource_id
  http_method             = aws_api_gateway_method.method_remove_product.http_method

  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = module.lambda_remove_product.invoke_arn
}

resource "aws_api_gateway_method" "method_get_products" {
  rest_api_id             = aws_api_gateway_rest_api.base_api.id
  resource_id             = aws_api_gateway_resource.products.id
  http_method             = "GET"
  authorization           = "NONE"
}

resource "aws_api_gateway_integration" "integration_get_products" {
  rest_api_id             = aws_api_gateway_rest_api.base_api.id
  resource_id             = aws_api_gateway_method.method_get_products.resource_id
  http_method             = aws_api_gateway_method.method_get_products.http_method

  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = module.lambda_get_products.invoke_arn
}

resource "aws_api_gateway_method" "method_create_product" {
  rest_api_id             = aws_api_gateway_rest_api.base_api.id
  resource_id             = aws_api_gateway_resource.products.id
  http_method             = "POST"
  authorization           = "NONE"
}



resource "aws_api_gateway_integration" "integration_create_product" {
  rest_api_id             = aws_api_gateway_rest_api.base_api.id
  resource_id             = aws_api_gateway_method.method_create_product.resource_id
  http_method             = aws_api_gateway_method.method_create_product.http_method

  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = module.lambda_create_product.invoke_arn
}

resource "aws_api_gateway_deployment" "deploy_routers" {
   depends_on = [
      aws_api_gateway_integration.integration_get_product,
      aws_api_gateway_integration.integration_remove_product,
      aws_api_gateway_integration.integration_get_products,
      aws_api_gateway_integration.integration_create_product,
   ]

   rest_api_id = aws_api_gateway_rest_api.base_api.id
   stage_name  = "dev"
}

resource "aws_lambda_permission" "get_products" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = module.lambda_get_products.function_name
  principal     = "apigateway.amazonaws.com"

  source_arn = "${aws_api_gateway_rest_api.base_api.execution_arn}/*/*"
}

resource "aws_lambda_permission" "create_product" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = module.lambda_create_product.function_name
  principal     = "apigateway.amazonaws.com"

  source_arn = "${aws_api_gateway_rest_api.base_api.execution_arn}/*/*"
}

resource "aws_lambda_permission" "get_product" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = module.lambda_get_product.function_name
  principal     = "apigateway.amazonaws.com"

  source_arn = "${aws_api_gateway_rest_api.base_api.execution_arn}/*/*"
}

resource "aws_lambda_permission" "remove_product" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = module.lambda_remove_product.function_name
  principal     = "apigateway.amazonaws.com"

  source_arn = "${aws_api_gateway_rest_api.base_api.execution_arn}/*/*"
}
