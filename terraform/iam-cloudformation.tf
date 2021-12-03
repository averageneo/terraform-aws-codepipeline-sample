resource "aws_iam_role" "cloudformation-iam-role" {
  name = "${var.CLOUDFORMATION_STACK_NAME}-cloudformation-role"

  assume_role_policy = <<EOF
{
   "Version": "2012-10-17",
   "Statement": [
     {
       "Effect": "Allow",
       "Principal": {
         "Service": "cloudformation.amazonaws.com"
       },
       "Action": "sts:AssumeRole"
     }
   ]
 }
EOF
}

data "aws_iam_policy_document" "cloudformation-policies" {
  statement {
    sid       = ""
    actions   = ["logs:*", "s3:*", "cloudformation:*", "s3-object-lambda:*", "iam:*", "ecr:*", "lambda:*"]
    resources = ["*"]
    effect    = "Allow"
  }
}

resource "aws_iam_policy" "cloudformation-policy" {
  name        = "${var.CLOUDFORMATION_STACK_NAME}-policy"
  path        = "/"
  description = "Cloudformation Policy"
  policy      = data.aws_iam_policy_document.cloudformation-policies.json
}
resource "aws_iam_role_policy_attachment" "cloudformation-role-policy-attachment" {
  policy_arn = aws_iam_policy.cloudformation-policy.arn
  role       = aws_iam_role.cloudformation-iam-role.id
}
