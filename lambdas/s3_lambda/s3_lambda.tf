data "archive_file" "lambda_zip_dir" {
  type        = "zip"
  output_path = "/tmp/lambda_zip_dir.zip"
	source_dir  = "./src/s3_lambda"
}

resource "aws_lambda_function" "reify_s3_lambda" {
  filename         = "${data.archive_file.lambda_zip_dir.output_path}"
  source_code_hash = "${data.archive_file.lambda_zip_dir.output_base64sha256}"

  function_name = "reify-s3-lambda"
  role          = var.lambda_role_arn
  handler       = "index.lambda_handler"

  runtime       = "python3.8"

  environment {
    variables = {
      S3_BUCKET_ARN = var.lambda_role_arn
      IAM_ROLE_ARN  = var.main_bucket_arn
    }
  }
}