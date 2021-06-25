data "aws_iam_policy_document" "lambda_get_product"{
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

module "lambda_get_product" {
  source        = "./modules/lambda"
  policy_json   = data.aws_iam_policy_document.lambda_get_product.json
  name          = "get-products"
  handler       = "src/controllers/products/get/index.handler"
}
