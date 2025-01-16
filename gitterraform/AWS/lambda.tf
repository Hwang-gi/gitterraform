# Docker Image 사용하여 Lambda 실행

resource "aws_iam_role" "iam_for_lambda" {
  name = "iam-for-lambda"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
        Effect   = "Allow"
        Sid      = ""
      },
    ]
  })
}

# resource "aws_lambda_function" "s3_lambda" {
#   function_name = "s3-lambda-function"
#   role = aws_iam_role.iam_for_lambda.arn

# }
