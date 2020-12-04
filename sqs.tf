resource "aws_sqs_queue_policy" "sqs_queue_policy" {
  queue_url = aws_sqs_queue.orders_queue.id
  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Id": "Policy1607066400895",
  "Statement": [
    {
      "Sid": "Stmt1607066399580",
      "Effect": "Allow",
      "Principal": "*",
      "Action": "sqs:*",
      "Resource": "arn:aws:sqs:us-east-1:727646912140:orders-queue",
      "Condition": {
        "ArnEquals": {
          "aws:SourceArn": "arn:aws:sns:us-east-1:727646912140:orders"
        }
      }
    }
  ]
}
POLICY
}


resource "aws_sqs_queue" "orders_queue" {
  name                      = "orders-queue"
  max_message_size          = 2048
  message_retention_seconds = 86400
}