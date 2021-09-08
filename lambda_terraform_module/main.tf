data "archive_file" "zip" {
  type        = "zip"
  output_path = "../bin/${var.lambda_name}.zip"
  source_dir  = "../${var.lambda_name}"
}

resource "aws_lambda_function" "lambda" {
  function_name = var.lambda_name

  filename         = data.archive_file.zip.output_path
  source_code_hash = data.archive_file.zip.output_base64sha256

  role    = var.iam_role_arn
  handler = "${var.lambda_name}.lambda_handler"
  runtime = "python3.8"
  memory_size = 128
  layers = [
    var.lambda_layer_arn,
  ]

  depends_on = [
    aws_cloudwatch_log_group.lambda_log_group,
  ]
}

resource "aws_cloudwatch_log_group" "lambda_log_group" {
  name              = "/aws/lambda/${var.lambda_name}"
  retention_in_days = 14
}
