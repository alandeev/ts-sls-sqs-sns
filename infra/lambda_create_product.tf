data "aws_iam_policy_document" "lambda_create_product"{
  statement {
    actions = ["logs:*"]
    resources = ["*"]
  }

  statement {
    actions = [
      "dynamodb:PutItem"
    ]

    resources = [
      aws_dynamodb_table.products.arn
    ]
  }
}

module "lambda_create_product" {
  source        = "./modules/lambda"
  policy_json   = data.aws_iam_policy_document.lambda_create_product.json
  name          = "create-product"
  handler       = "src/controllers/products/create/index.handler"

  enviroments = {
    DYNAMO_TABLE_PRODUCTS: "products"
  }
}
