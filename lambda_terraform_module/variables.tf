variable "lambda_name" {
  description = "The name given to the lambda function"
  type        = string
}

variable "aws_region" {
  description = "The AWS region to create things in."
  type        = string
}

variable "iam_role_arn" {
  description = "The ARN of the IAM role for the lambda to use"
  type        = string
}

variable "lambda_layer_arn" {
  description = "The ARN of the lambda layer to attach to the lambda."
  type        = string
}
