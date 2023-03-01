########################################
###              Lambda              ###
########################################
#tfsec:ignore:aws-lambda-enable-tracing
resource "aws_lambda_function" "lambda" {
  for_each      = var.apps
  function_name = "${each.value.name}-${var.project_identifier}"
  role          = aws_iam_role.iam_for_lambda.arn
  handler       = "main"

  filename    = "${path.module}/src/dummy.zip"
  runtime     = "go1.x"
  memory_size = 128

  environment {
    variables = {
      DATABASE_NAME = var.project_identifier
    }
  }

  lifecycle {
    # environment variables are managed by the CI/CD
    # filename is only for the dummy.zip to be ignored
    # s3_bucket is managed by the CI/CD
    ignore_changes = [environment, filename, s3_bucket]
  }

  tags = var.common_tags
}

########################################
###               IAM                ###
########################################
resource "aws_iam_role" "iam_for_lambda" {
  name = "lambda-${var.project_identifier}"

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

# Allows Lambda to send logs to cloudwatch
resource "aws_iam_role_policy_attachment" "AWSLambdaBasicExecutionRole" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
  role       = aws_iam_role.iam_for_lambda.name
}

# Allows Lambda full access to DynamoDB
resource "aws_iam_role_policy_attachment" "AmazonDynamoDBFullAccess" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonDynamoDBFullAccess"
  role       = aws_iam_role.iam_for_lambda.name
}

# Allows Lambda read access to S3 buckets
resource "aws_iam_role_policy_attachment" "AmazonS3ReadOnlyAccess" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
  role       = aws_iam_role.iam_for_lambda.name
}

# Allows Lambda to Encrypt/Decrypt DynamoDB KMS
#tfsec:ignore:aws-iam-no-policy-wildcards
resource "aws_iam_policy" "lambda_kms" {
  name        = "lambda-kms-${var.project_identifier}"
  description = "IAM policy for logging from a lambda"

  policy = jsonencode(
    {
      Version = "2012-10-17",
      Statement = [
        {
          Action = [
            "kms:Decrypt",
            "kms:DescribeKey",
            "kms:Encrypt",
            "kms:ReEncrypt*",
            "kms:Get*",
            "kms:List*"
          ],
          Effect   = "Allow",
          Resource = var.dynamodb_kms_key_arn
        }
      ]
    }
  )

  tags = var.common_tags
}

resource "aws_iam_role_policy_attachment" "lambda_kms" {
  policy_arn = aws_iam_policy.lambda_kms.arn
  role       = aws_iam_role.iam_for_lambda.name
}
