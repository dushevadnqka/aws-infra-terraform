data "archive_file" "lambda_layer_zip_dir" {
  type        = "zip"
  output_path = "/tmp/lambda_layer_zip_dir.zip"
	source_dir  = "./src/lambda_layer_1"
}

resource "aws_lambda_layer_version" "reify_shared_lambda" {
  filename         = "${data.archive_file.lambda_layer_zip_dir.output_path}"
  source_code_hash = "${data.archive_file.lambda_layer_zip_dir.output_base64sha256}"

  layer_name = var.lambda_layer_name

  description = "This is a test layer."

  compatible_runtimes = ["python3.8"]
}
