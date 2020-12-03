resource "aws_sqs_queue_policy" "sqs_queue_policy" {
  queue_url = aws_sqs_queue.orders_queue.id
  policy = <<POLICY
{
  "Id": "Policy1606976892127",
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "Stmt1606976883256",
      "Action": [
        "sqs:SendMessage"
      ],
      "Effect": "Allow",
      "Resource": "arn:aws:sqs:us-east-1:727646912140:orders-queue",
      "Condition": {
        "IpAddress": {
          "aws:SourceIp": "189.100.68.5"
        }
      },
      "Principal": "*"
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