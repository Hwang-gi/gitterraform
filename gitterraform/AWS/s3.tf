resource "aws_s3_bucket" "bucket" {
  bucket = "hgc-s3-bucket"

  tags = {
    Name = "hgc-s3-bucket"
    Environment = "${var.vpc_prefix}"
  }
}

# Connecting to AWS Lambda Resource
resource "aws_iam_policy" "s3_lambda_policy" {
  name = "s3-lambda-policy"

  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "logs:PutLogEvents",
                "logs:CreateLogGroup",
                "logs:CreateLogStream"
            ],
            "Resource": "arn:aws:logs:*:*:*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "s3:GetObject"
            ],
            "Resource": "arn:aws:s3:::unique-s3-bucket/*"
        }
    ]
}
  )
}

resource "aws_iam_role_policy_attachment" "lambda_s3_attachment" {
  policy_arn = aws_iam_policy.s3_lambda_policy.arn
  role       = aws_iam_role.iam_for_lambda.name
}
