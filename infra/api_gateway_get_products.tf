resource "aws_api_gateway_rest_api" "products" {
  name                  = "products"
  description           = "Object to products"
}

resource "aws_api_gateway_resource" "proxy" {
  rest_api_id           = aws_api_gateway_rest_api.products.id
  parent_id             = aws_api_gateway_rest_api.products.root_resource_id
  path_part             = "products"
}

resource "aws_api_gateway_method" "proxy" {
  rest_api_id           = aws_api_gateway_rest_api.products.id
  resource_id           = aws_api_gateway_resource.proxy.id
  http_method           = "ANY"
  authorization         = "NONE"
}

resource "aws_api_gateway_integration" "get_products" {
  rest_api_id = aws_api_gateway_rest_api.products.id
  resource_id = aws_api_gateway_method.proxy.resource_id
  http_method = aws_api_gateway_method.proxy.http_method

  integration_http_method = "GET"
  type                    = "AWS_PROXY"
  uri                     = module.lambda_get_product.invoke_arn
}
