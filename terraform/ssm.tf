resource "aws_ssm_parameter" "parameter" {
  name  = "lambda_test_parameter"
  type  = "String"
  value = "Initial value"
}
