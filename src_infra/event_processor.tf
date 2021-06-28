data "aws_iam_policy_document" "event_processor" {
  statement {
    actions = [
      "lambda:InvokeFunction",
    ]

    resources = [module.event_processor.arn]
  }
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

    resources = ["*"]
  }
  statement {
    actions = ["sns:Publish"]
    resources  = ["*"]
  }
}

module "event_processor" {
  source        = "./modules/lambda"
  policy_json   = data.aws_iam_policy_document.event_processor.json
  name          = "event-processor"
  handler       = "src/event-processor/index.handler"

  enviroments = {
    DYNAMO_TABLE_PRODUCTS: "products"
  }
}
