resource "aws_dynamodb_table" "orders-dynamodb-table" {
  name           = "Orders"
  billing_mode   = "PROVISIONED"
  read_capacity  = 5
  write_capacity = 5
  hash_key       = "id"
  range_key      = "name"

  attribute {
    name = "id"
    type = "S"
  }

  attribute {
    name = "name"
    type = "S"
  }

  attribute {
    name = "value"
    type = "N"
  }

  global_secondary_index {
    name               = "nameIndex"
    hash_key           = "name"
    range_key          = "value"
    write_capacity     = 5
    read_capacity      = 5
    projection_type    = "INCLUDE"
    non_key_attributes = ["id"]
  }

  tags = {
    Name        = "orders-table"
    Environment = "dev"
  }
}