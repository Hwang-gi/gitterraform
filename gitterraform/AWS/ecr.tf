data "aws_ecr_repository" "frontend" {
  name = "frontend-ecr"
}

data "aws_ecr_repository" "backend" {
  name = "backend-ecr"
}

resource "aws_ecr_repository" "frontend" {
  count = length(data.aws_ecr_repository.frontend.id) == 0 ? 1 : 0
  name = "frontend-ecr"
  image_tag_mutability = "IMMUTABLE"
}

resource "aws_ecr_repository" "backend" {
  count = length(data.aws_ecr_repository.backend.id) == 0 ? 1 : 0
  name = "backend-ecr"
  image_tag_mutability = "IMMUTABLE"
}
