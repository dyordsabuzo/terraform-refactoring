## Create ECR repository
resource "aws_ecr_repository" "repository" {
  count                = length(var.repository_list)
  name                 = element(var.repository_list, count.index)
  image_tag_mutability = "IMMUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}

## Build docker images and push to ECR
resource "docker_registry_image" "image" {
  count = length(var.repository_list)
  name  = "${aws_ecr_repository.repository[count.index].repository_url}:${data.external.git.result.value}"

  build {
    context    = "${path.cwd}/application"
    dockerfile = "${element(var.repository_list, count.index)}.Dockerfile"
  }
}

## Setup proper credentials to push to ECR
