# Lambdas Configuration

# Layers Configuration

resource "null_resource" "build_lambda_layers" {
  triggers = {
    "layer_build" = filemd5("${path.module}/lambda-layer/nodejs/package.json")
    "lib"         = filemd5("${path.module}/lambda-layer/nodejs/shared-helpers.js")
  }

  provisioner "local-exec" {
    command = "cd ${path.module}/lambda-layer/nodejs && npm install && cd .. && zip -r nodejs.zip ."
  }
}

resource "aws_lambda_layer_version" "orders_layer" {
  filename            = "${path.module}/lambda-layer/nodejs.zip"
  layer_name          = "lambdas-layer"
  compatible_runtimes = ["nodejs12.x"]
  depends_on = [
    null_resource.build_lambda_layers
  ]
}

# Lambda Zip

data "archive_file" "lambda_receipt_order" {
  type        = "zip"
  source_file = "${path.module}/lambdas/orders/receipt-order.js"
  output_path = "${path.module}/lambdas/orders/receipt-order.js.zip"
}

data "archive_file" "lambda_create_order" {
  type        = "zip"
  source_file = "${path.module}/lambdas/orders/create-order.js"
  output_path = "${path.module}/lambdas/orders/create-order.js.zip"
}

data "archive_file" "lambda_confirm_order" {
  type        = "zip"
  source_file = "${path.module}/lambdas/orders/confirm-order.js"
  output_path = "${path.module}/lambdas/orders/confirm-order.js.zip"
}

# Lambda Role

resource "aws_iam_role" "iam_lambdas" {
  name = "iam_for_lambda"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

# Lambda Policy

resource "aws_iam_policy" "lambdas_policy" {
  policy = data.aws_iam_policy_document.lambdas_policy_document.json
}

data "aws_iam_policy_document" "lambdas_policy_document" {
  statement {
    sid    = "AllowWritingLogs"
    effect = "Allow"
    actions = [
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]
    resources = ["arn:aws:logs:*"]
  }
  statement {
    sid    = "AllowDynamoPermissions"
    effect = "Allow"
    actions = [
      "dynamodb:*"
    ]
    resources = ["*"]
  }
  statement {
    sid    = "AllowCreatingLogGroups"
    effect = "Allow"
    actions = [
      "logs:CreateLogGroup",
    ]
    resources = ["arn:aws:logs:*"]
  }

  statement {
    sid    = "AllowSnsPermissions"
    effect = "Allow"
    actions = [
      "SNS:Subscribe",
      "SNS:SetTopicAttributes",
      "SNS:Receive",
      "SNS:Publish",
    ]
    resources = [
      "arn:aws:sns:*"
    ]
  }
}

# Lambda Policy Attachment

resource "aws_iam_policy_attachment" "lambda_orders_attach_policy" {
  name       = "orders-attachment-policy"
  policy_arn = aws_iam_policy.lambdas_policy.arn
  roles      = [aws_iam_role.iam_lambdas.name]
}

# Lambdas

resource "aws_lambda_function" "receipt_order_lambda" {
  filename         = data.archive_file.lambda_receipt_order.output_path
  function_name    = "receipt-order"
  role             = aws_iam_role.iam_lambdas.arn
  handler          = "receipt-order.handler"
  layers           = [aws_lambda_layer_version.orders_layer.arn]
  source_code_hash = filebase64sha256(data.archive_file.lambda_receipt_order.output_path)
  runtime          = "nodejs12.x"
  timeout          = 10
}

resource "aws_lambda_function" "confirm_order_lambda" {
  filename         = data.archive_file.lambda_confirm_order.output_path
  function_name    = "confirm-order"
  role             = aws_iam_role.iam_lambdas.arn
  handler          = "confirm-order.handler"
  layers           = [aws_lambda_layer_version.orders_layer.arn]
  source_code_hash = filebase64sha256(data.archive_file.lambda_confirm_order.output_path)
  runtime          = "nodejs12.x"
  timeout          = 10
}


resource "aws_lambda_function" "order_lambda" {
  filename         = data.archive_file.lambda_create_order.output_path
  function_name    = "create-orders"
  role             = aws_iam_role.iam_lambdas.arn
  handler          = "create-order.handler"
  layers           = [aws_lambda_layer_version.orders_layer.arn]
  source_code_hash = filebase64sha256(data.archive_file.lambda_create_order.output_path)
  runtime          = "nodejs12.x"
  timeout          = 10
}


