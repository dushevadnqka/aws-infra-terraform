output "reify_shared_lambda_layer" {
  value       = aws_lambda_layer_version.reify_shared_lambda.arn
  description = "The ARN of the lambda layer."

  depends_on = [
    aws_lambda_layer_version.reify_shared_lambda,
  ]
}
