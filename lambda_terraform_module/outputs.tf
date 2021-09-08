output "lambda_arn" {
  value = aws_lambda_function.lambda.qualified_arn
}

output "invoke_arn" {
  value = aws_lambda_function.lambda.invoke_arn
}
