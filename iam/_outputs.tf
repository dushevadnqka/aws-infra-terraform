output "lambda_role_arn" {
  value       = aws_iam_role.lambda_s3_handler.arn
  description = "The ARN of the role which could access the bucket"

  depends_on = [
    aws_iam_role.lambda_s3_handler,
  ]
}
