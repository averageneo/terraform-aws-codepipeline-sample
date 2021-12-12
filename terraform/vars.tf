variable "AWS_REGION" {
  type    = string
  default = "ca-central-1"
}
variable "AWS_PIPELINE_NAME" { type = string }
variable "REPOSITORY_ID" { type = string }
variable "BRANCH_NAME" { type = string }
variable "AWS_CODEPIPELINE_S3_BUCKET_ARTIFACT" { type = string }
variable "CODE_STAR_CONNECTION_ARN" { type = string }
variable "CODEBUILD_NAME" { type = string }
variable "ECR_IMAGE_NAME" { type = string }
variable "CLOUDFORMATION_STACK_NAME" { type = string }
variable "CLOUDFORMATION_PARAMETERS" {
  type = map(any)
}

variable "ECR_IMAGE_TAG" {
  type = string
}

variable "AWS_ECR_URL" { type = string }