data "aws_iam_policy_document" "lambda_processor_events" {
  statement {
    actions = ["logs:*"]
    resources = ["*"]
  }

  statement {
    actions = [
      "dynamodb:DescribeStream",
      "dynamodb:GetRecords",
      "dynamodb:GetShardIterator",
      "dynamodb:ListStreams"
    ]

    resources = [
      aws_dynamodb_table.products_events.arn
    ]
  }
  statement {
    actions = ["sns:Publish"]
    resources  = ["*"]
  }
}

resource "aws_lambda_event_source_mapping" "products_source_mapping" {
  event_source_arn =  aws_dynamodb_table.products_events.arn
  function_name = module.lambda_event_processor.arn

  depends_on = [
    module.lambda_event_processor.arn,
    aws_dynamodb_table.products_events.arn
  ]
}

module "lambda_event_processor" {
  source        = "./modules/lambda"
  policy_json   = data.aws_iam_policy_document.lambda_processor_events.json
  name          = "get-product"
  handler       = "src/controllers/products/get-by-id/index.handler"
}

resource "aws_dynamodb_table" "products_events" {
  name = "products-events"
  read_capacity = 1
  write_capacity = 1
  billing_mode = "PROVISIONED"
  stream_enabled = true
  stream_view_type = "NEW_AND_OLD_IMAGES"

  hash_key = "id"
  range_key = "action"

  attribute {
    name = "id"
    type = "S"
  }

  attribute {
    name = "action"
    type = "S"
  }
}
