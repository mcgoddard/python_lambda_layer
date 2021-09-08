module "lambda_1" {
  source             = "../lambda_terraform_module"

  lambda_name        = "lambda_1"
  iam_role_arn       = aws_iam_role.iam_for_lambda_read_only.arn
  aws_region         = var.aws_region
  lambda_layer_arn   = aws_lambda_layer_version.lambda_layer.arn
}

module "lambda_2" {
  source             = "../lambda_terraform_module"

  lambda_name        = "lambda_2"
  iam_role_arn       = aws_iam_role.iam_for_lambda_write_only.arn
  aws_region         = var.aws_region
  lambda_layer_arn   = aws_lambda_layer_version.lambda_layer.arn
}

data "archive_file" "zip" {
  type        = "zip"
  output_path = "../bin/common.zip"
  source_dir  = "../common"
}

resource "aws_lambda_layer_version" "lambda_layer" {
  filename         = data.archive_file.zip.output_path
  source_code_hash = data.archive_file.zip.output_base64sha256
  layer_name = "common_lambda_layer"

  compatible_runtimes = ["python3.8"]
}
