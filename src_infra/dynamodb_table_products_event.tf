resource "aws_lambda_event_source_mapping" "products_source_mapping" {
  event_source_arn =  aws_dynamodb_table.products_events.stream_arn
  function_name = module.lambda_event_processor.arn
  starting_position = "LATEST"

  depends_on = [
    module.event_processor,
    aws_dynamodb_table.products_events
  ]
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
