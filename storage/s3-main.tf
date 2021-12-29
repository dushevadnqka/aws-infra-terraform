resource "aws_s3_bucket" "main_bucket" {
  bucket = "reify-main-bucket"
}

resource "aws_s3_bucket_policy" "restrict_access_to_198" {
  bucket = aws_s3_bucket.main_bucket.id
  policy = data.aws_iam_policy_document.restrict_access_to_198.json
}

data "aws_iam_policy_document" "restrict_access_to_198" {
  statement {
    principals {
      type        = "AWS"
      identifiers = [
        var.lambda_role_arn
      ]
    }

    actions = [
      "s3:GetObject",
      "s3:ListBucket",
      "s3:PutObject"
    ]

    resources = [
      aws_s3_bucket.main_bucket.arn,
      "${aws_s3_bucket.main_bucket.arn}/*",
    ]
  }
}

resource "aws_s3_bucket_public_access_block" "block_main_bucket_public_access" {
  bucket = aws_s3_bucket.main_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
