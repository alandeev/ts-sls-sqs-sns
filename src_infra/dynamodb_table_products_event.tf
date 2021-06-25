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
