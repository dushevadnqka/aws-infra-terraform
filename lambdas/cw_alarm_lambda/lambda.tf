data "archive_file" "lambda_zip_dir" {
  type        = "zip"
  output_path = "/tmp/lambda_zip_dir.zip"
	source_dir  = "./src/cw_alarm_lambda"
}

resource "aws_lambda_function" "reify_s3_lambda" {
  filename         = "${data.archive_file.lambda_zip_dir.output_path}"
  source_code_hash = "${data.archive_file.lambda_zip_dir.output_base64sha256}"

  function_name = "reify-cw-lambda"
  role          = var.lambda_role_arn
  handler       = "index.lambda_handler"

  runtime       = "python3.8"

  environment {
    variables = {
      IAM_ROLE_ARN  = var.lambda_role_arn
    }
  }
}