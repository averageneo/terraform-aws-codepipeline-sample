resource "aws_iam_role" "codebuild-iam-role" {
  name = "${var.CODEBUILD_NAME}-codebuild-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "codebuild.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

data "aws_iam_policy_document" "codebuild-policies" {
  statement {
    sid       = ""
    actions   = ["logs:*", "s3:*", "codebuild:*", "secretsmanager:*", "iam:*", "ecr:*", "lambda:*"]
    resources = ["*"]
    effect    = "Allow"
  }
}

resource "aws_iam_policy" "codebuild-policy" {
  name        = "${var.CODEBUILD_NAME}-policy"
  path        = "/"
  description = "Codebuild Policy"
  policy      = data.aws_iam_policy_document.codebuild-policies.json
}

resource "aws_iam_role_policy_attachment" "codebuild-role-policy-attachment" {
  policy_arn = aws_iam_policy.codebuild-policy.arn
  role       = aws_iam_role.codebuild-iam-role.id
}