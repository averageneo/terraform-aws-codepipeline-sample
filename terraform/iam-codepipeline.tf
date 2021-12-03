resource "aws_iam_role" "codepipeline-iam-role" {
  name               = "${var.AWS_PIPELINE_NAME}-codepipeline-role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "codepipeline.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF

}

data "aws_iam_policy_document" "codepipeline-policies" {
  statement {
    sid       = ""
    actions   = ["codestar-connections:UseConnection"]
    resources = ["*"]
    effect    = "Allow"
  }
  statement {
    sid       = ""
    actions   = ["cloudwatch:*", "s3:*", "codebuild:*"]
    resources = ["*"]
    effect    = "Allow"
  }
  statement {
    sid       = ""
    actions   = ["cloudformation:*", "iam:PassRole"]
    resources = ["*"]
    effect    = "Allow"
  }
}

resource "aws_iam_policy" "codepipeline-policy" {
  name        = "${var.AWS_PIPELINE_NAME}-policy"
  path        = "/"
  description = "Pipeline Policy"
  policy      = data.aws_iam_policy_document.codepipeline-policies.json
}

resource "aws_iam_role_policy_attachment" "codepipeline-role-policy-attachment" {
  policy_arn = aws_iam_policy.codepipeline-policy.arn
  role       = aws_iam_role.codepipeline-iam-role.id
}