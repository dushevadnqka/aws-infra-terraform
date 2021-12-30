variable "lambda_role_arn" {
  type        = string
  description = "The ARN of the role for lambda."

#   validation {
#     condition     = length(var.lambda_role_name) > 4 && substr(var.lambda_role_name, 0, 9) == "lambda_s3"
#     error_message = "The image_id value must be a valid lambda role name, starting with \"lambda_s3\"."
#   }
}

variable "main_bucket_arn" {
  type        = string
  description = "The ARN of the bucket."

#   validation {
#     condition     = length(var.lambda_role_name) > 4 && substr(var.lambda_role_name, 0, 9) == "lambda_s3"
#     error_message = "The image_id value must be a valid lambda role name, starting with \"lambda_s3\"."
#   }
}

variable "lambda_function_name" {
  type = string
  description = "The name of the lambda function"
  default = "reify-s3-lambda"
}

variable "reify_shared_lambda_layer" {
  type = string
  description = "The ARN of the lambda layer"
}