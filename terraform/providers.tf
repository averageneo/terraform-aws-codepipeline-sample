provider "aws" {
  region = var.AWS_REGION
}

provider "docker" {
  registry_auth {
    address  = var.AWS_ECR_URL
    username = data.aws_ecr_authorization_token.token.user_name
    password = data.aws_ecr_authorization_token.token.password
  }
}