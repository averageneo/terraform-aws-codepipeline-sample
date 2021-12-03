resource "aws_codepipeline" "codepipeline" {
  name     = var.AWS_PIPELINE_NAME
  role_arn = aws_iam_role.codepipeline-iam-role.arn

  artifact_store {
    type     = "S3"
    location = aws_s3_bucket.codepipeline-s3-artifact.id
  }

  stage {
    name = "Source"

    action {
      name             = "Source"
      category         = "Source"
      owner            = "AWS"
      provider         = "CodeStarSourceConnection"
      version          = 1
      output_artifacts = ["source"]


      configuration = {
        ConnectionArn    = "${var.CODE_STAR_CONNECTION_ARN}"
        FullRepositoryId = "${var.REPOSITORY_ID}"
        BranchName       = "${var.BRANCH_NAME}"
      }
    }
  }

  stage {
    name = "Build-Deploy"

    action {
      name            = "Build-Deploy"
      category        = "Build"
      owner           = "AWS"
      provider        = "CodeBuild"
      version         = 1
      input_artifacts = ["source"]

      configuration = {
        ProjectName = aws_codebuild_project.codebuild.name
      }
    }
  }

  stage {
    name = "Update-CloudFormation-Stack"

    action {
      name            = "Update-CloudFormation-Stack"
      category        = "Deploy"
      owner           = "AWS"
      provider        = "CloudFormation"
      version         = 1
      input_artifacts = ["source"]

      configuration = {
        ActionMode   = "CREATE_UPDATE"
        StackName    = aws_cloudformation_stack.cloudformation-stack.name
        Capabilities = "CAPABILITY_IAM,CAPABILITY_NAMED_IAM,CAPABILITY_AUTO_EXPAND"
        RoleArn      = aws_iam_role.cloudformation-iam-role.arn
        TemplatePath = "source::cloudformation/template.yml"
        ParameterOverrides = jsonencode(merge(var.CLOUDFORMATION_PARAMETERS, { "ImageUri" = "${aws_ecr_repository.ECR.repository_url}:${var.ERC_IMAGE_TAG}" }))
      }
    }
  }

  depends_on = [
    aws_cloudformation_stack.cloudformation-stack
  ]
}
