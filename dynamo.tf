resource "aws_dynamodb_table" "orders-dynamodb-table" {
  name           = "Orders"
  billing_mode   = "PROVISIONED"
  read_capacity  = 5
  write_capacity = 5
  hash_key       = "id"

  attribute {
    name = "id"
    type = "S"
  }

  tags = {
    Name        = "orders-table"
    Environment = "dev"
  }
}


resource "aws_dynamodb_table" "receipt-dynamodb-table" {
  name           = "Receipts"
  billing_mode   = "PROVISIONED"
  read_capacity  = 5
  write_capacity = 5
  hash_key       = "id"

  attribute {
    name = "id"
    type = "S"
  }

  tags = {
    Name        = "receipt-table"
    Environment = "dev"
  }
}