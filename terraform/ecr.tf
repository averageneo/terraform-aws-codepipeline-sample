resource "aws_ecr_repository" "ECR" {
  name                 = var.ECR_IMAGE_NAME
  image_tag_mutability = "MUTABLE"
}