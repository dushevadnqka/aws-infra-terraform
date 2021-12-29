terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }

  required_version = ">= 0.14.9"
}

provider "aws" {
  profile = "default"
  region  = "eu-west-1"
}

module "iam_module" {
  source = "./iam"

  main_bucket_arn = module.s3_module.main_bucket_arn
}

module "s3_module" {
  source = "./storage"

  lambda_role_arn = module.iam_module.lambda_role_arn
}

# module "lambda_s3" {
#   source = "./lambdas/s3_lambda"

#   main_bucket_arn = module.s3_module.main_bucket_arn
#   lambda_role_arn = module.iam_module.lambda_role_arn
# }

# module "lambda_cw_alarm" {
#   source = "./lambdas/cw_alarm_lambda"

#   lambda_role_arn = module.iam_module.lambda_role_arn
# }

module "lambda_module" {
  source = "terraform-aws-modules/lambda/aws"

  function_name = "reify-s3-lambda"
  description   = "My awesome lambda function"
  handler       = "index.lambda_handler"
  runtime       = "python3.8"

  source_path = "./lambdas/src/s3_lambda"

  environment_variables = {
    S3_BUCKET_ARN = module.iam_module.lambda_role_arn
    IAM_ROLE_ARN  = module.s3_module.main_bucket_arn

  }

  tags = {
    Name = "reify-s3-lambda"
  }
}
