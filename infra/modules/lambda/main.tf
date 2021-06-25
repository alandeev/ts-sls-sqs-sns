module "lambda_role" {
  source      = "../lambda_role"
  name        = "${var.name}"
  policy_json = var.policy_json
}

resource "aws_lambda_function" "main" {
  function_name = var.name
  role          = module.lambda_role.arn
  handler       = var.handler == "" ? "src/controllers/${var.name}.handler" : var.handler
  runtime       = "nodejs14.x"
  s3_bucket     = "lambdas-alan"
  s3_key        = "deploy/${var.name}/latest.zip"
  timeout       = "5"
  memory_size   = "1024"
}
