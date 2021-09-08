resource "aws_iam_policy" "read_policy" {
  name        = "ssm-read-only-access"
  description = "Grant access read only to the ssm parameter."

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "ssm:GetParameter"
      ],
      "Effect": "Allow",
      "Resource": ["${aws_ssm_parameter.parameter.arn}"]
    }
  ]
}
EOF
}

resource "aws_iam_policy" "write_policy" {
  name        = "ssm-write-only-access"
  description = "Grant access write only to the ssm parameter."

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "ssm:PutParameter"
      ],
      "Effect": "Allow",
      "Resource": ["${aws_ssm_parameter.parameter.arn}"]
    }
  ]
}
EOF
}

resource "aws_iam_role" "iam_for_lambda_read_only" {
  name               = "iam_for_lambda_ssm_read_only"
  assume_role_policy = data.aws_iam_policy_document.policy.json
}

resource "aws_iam_role_policy_attachment" "read_only_policy_attachment" {
  role       = aws_iam_role.iam_for_lambda_read_only.name
  policy_arn = aws_iam_policy.read_policy.arn
}

resource "aws_iam_role" "iam_for_lambda_write_only" {
  name               = "iam_for_lambda_ssm_write_only"
  assume_role_policy = data.aws_iam_policy_document.policy.json
}

resource "aws_iam_role_policy_attachment" "write_only_policy_attachment" {
  role       = aws_iam_role.iam_for_lambda_write_only.name
  policy_arn = aws_iam_policy.write_policy.arn
}

data "aws_iam_policy_document" "policy" {
  statement {
    sid    = ""
    effect = "Allow"

    principals {
      identifiers = ["lambda.amazonaws.com"]
      type        = "Service"
    }

    actions = ["sts:AssumeRole"]
  }
}
