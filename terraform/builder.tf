resource "docker_registry_image" "docker-image" {
  name = "${aws_ecr_repository.ECR.repository_url}:${var.ERC_IMAGE_TAG}"

  build {
    context    = "../app"
    dockerfile = "Dockerfile"
  }
}