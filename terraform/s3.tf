resource "aws_s3_bucket" "codepipeline-s3-artifact" {
  bucket = var.AWS_CODEPIPELINE_S3_BUCKET_ARTIFACT
  acl    = "private"
}