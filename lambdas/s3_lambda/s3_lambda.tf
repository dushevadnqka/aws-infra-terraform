resource "aws_lambda_function" "reify_s3_lambda" {
  filename      = "lambda_function_s3_lambda.zip"
  function_name = "reify-s3-lambda"
  role          = var.lambda_role_arn
  handler       = "index.lambda_handler"

  # The filebase64sha256() function is available in Terraform 0.11.12 and later
  # For Terraform 0.11.11 and earlier, use the base64sha256() function and the file() function:
  # source_code_hash = "${base64sha256(file("lambda_function_payload.zip"))}"
  source_code_hash = filebase64sha256("lambda_function_s3_lambda.zip")

  runtime       = "python3.8"

  environment {
    variables = {
      S3_BUCKET_ARN = module.iam_module.lambda_role_arn
      IAM_ROLE_ARN  = module.s3_module.main_bucket_arn
    }
  }
}