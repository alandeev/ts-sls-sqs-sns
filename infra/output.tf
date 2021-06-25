output "lambda_get_product_arn" {
  value = module.lambda_get_product.arn
}

output "base_url" {
  value = aws_api_gateway_deployment.deploy_routers.invoke_url
}
