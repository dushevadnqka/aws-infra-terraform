data "archive_file" "lambda_zip_dir" {
  type        = "zip"
  output_path = "lambda/packages/lambda_function.zip"
	source_dir  = "./src/s3_lambda"
}

resource "aws_lambda_function" "reify_s3_lambda" {
  filename         = "${data.archive_file.lambda_zip_dir.output_path}"
  source_code_hash = "${data.archive_file.lambda_zip_dir.output_base64sha256}"

  function_name = var.lambda_function_name
  role          = var.lambda_role_arn
  handler       = "index.lambda_handler"

  runtime       = "python3.8"

  environment {
    variables = {
      S3_BUCKET_ARN = var.main_bucket_arn
      IAM_ROLE_ARN  = var.lambda_role_arn
    }
  }

  depends_on = [
    aws_cloudwatch_log_group.lambda_log_group,
  ]

  layers = [var.reify_shared_lambda_layer]
}

resource "aws_cloudwatch_log_group" "lambda_log_group" {
  name              = "/aws/lambda/${var.lambda_function_name}"
  retention_in_days = 1
}
