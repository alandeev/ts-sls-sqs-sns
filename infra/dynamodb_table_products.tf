resource "aws_dynamodb_table" "products" {
  name = "products"
  read_capacity = 1
  write_capacity = 1
  billing_mode = "PROVISIONED"
  hash_key = "id"

  attribute {
    name = "id"
    type = "S"
  }
}
