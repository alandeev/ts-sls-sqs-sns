data "aws_iam_policy_document" "lambda_remove_product"{
  statement {
    actions = ["logs:*"]
    resources = ["*"]
  }

  statement {
    actions = [
      "dynamodb:DeleteItem"
    ]

    resources = [
      aws_dynamodb_table.products.arn
    ]
  }
}

module "lambda_remove_product" {
  source        = "./modules/lambda"
  policy_json   = data.aws_iam_policy_document.lambda_remove_product.json
  name          = "remove-product"
  handler       = "src/controllers/products/remove/index.handler"

  enviroments = {
    DYNAMO_TABLE_PRODUCTS: "products"
  }
}
