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

module "lambda_layers" {
  source = "./lambdas/layers"
}

module "lambda_s3" {
  source = "./lambdas/s3_lambda"

  main_bucket_arn = module.s3_module.main_bucket_arn
  lambda_role_arn = module.iam_module.lambda_role_arn
  reify_shared_lambda_layer = module.lambda_layers.reify_shared_lambda_layer
}

# module "lambda_cw_alarm" {
#   source = "./lambdas/cw_alarm_lambda"

#   lambda_role_arn = module.iam_module.lambda_role_arn
# }
