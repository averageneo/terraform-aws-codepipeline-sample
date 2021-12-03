resource "aws_codebuild_project" "codebuild" {
  name         = var.CODEBUILD_NAME
  service_role = aws_iam_role.codebuild-iam-role.arn

  artifacts {
    type = "CODEPIPELINE"
  }

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/standard:5.0"
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"
    privileged_mode             = true

  }

  logs_config {
    cloudwatch_logs {
      group_name  = "/codebuild/${var.CODEBUILD_NAME}-log-group"
      stream_name = "/codebuild/${var.CODEBUILD_NAME}-log-stream"
    }
  }

  source {
    type      = "CODEPIPELINE"
    buildspec = file("../buildspec.yml")

    // git_submodules_config {
    //   fetch_submodules = true
    // }
  }

  depends_on = [
    aws_cloudformation_stack.cloudformation-stack,
  ]
}