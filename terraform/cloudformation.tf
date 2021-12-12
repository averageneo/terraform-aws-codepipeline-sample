resource "aws_cloudformation_stack" "cloudformation-stack" {
  name         = var.CLOUDFORMATION_STACK_NAME
  iam_role_arn = aws_iam_role.cloudformation-iam-role.arn
  parameters   = merge(var.CLOUDFORMATION_PARAMETERS, { "ImageUri" = "${aws_ecr_repository.ECR.repository_url}:${var.ECR_IMAGE_TAG}" })
  template_url = "https://something.com/template.yml"
  capabilities = ["CAPABILITY_IAM", "CAPABILITY_NAMED_IAM", "CAPABILITY_AUTO_EXPAND"]

  depends_on = [aws_ecr_repository.ECR, docker_registry_image.docker-image]
}
