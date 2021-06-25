data "aws_iam_policy_document" "lambda_get_products"{
  statement {
    actions = ["logs:*"]
    resources = ["*"]
  }

  statement {
    actions = [
      "dynamodb:Scan"
    ]

    resources = [
      aws_dynamodb_table.products.arn
    ]
  }
}

module "lambda_get_products" {
  source        = "./modules/lambda"
  policy_json   = data.aws_iam_policy_document.lambda_get_products.json
  name          = "get-products"
  handler       = "src/controllers/products/get/index.handler"

  enviroments = {
    DYNAMO_TABLE_PRODUCTS: "products"
  }
}
