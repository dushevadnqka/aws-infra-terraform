output "main_bucket_arn" {
  value       = aws_s3_bucket.main_bucket.arn
  description = "The ARN of the bucket."

  depends_on = [
    aws_s3_bucket.main_bucket,
  ]
}
