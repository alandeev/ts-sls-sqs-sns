data "aws_iam_policy_document" "lambda_get_product"{
  statement {
    actions = ["logs:*"]
    resources = ["*"]
  }

  statement {
    actions = [
      "dynamodb:GetItem"
    ]

    resources = [
      aws_dynamodb_table.products.arn
    ]
  }
}

module "lambda_get_product" {
  source        = "./modules/lambda"
  policy_json   = data.aws_iam_policy_document.lambda_get_product.json
  name          = "get-product"
  handler       = "src/controllers/products/get-by-id/index.handler"

  enviroments = {
    DYNAMO_TABLE_PRODUCTS: "products"
  }
}
