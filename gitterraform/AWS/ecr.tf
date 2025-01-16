resource "aws_ecr_repository" "frontend" {
  name = "frontend-ecr"
  image_tag_mutability = "IMMUTABLE"
}

resource "aws_ecr_repository" "backend" {
  name = "backend-ecr"
  image_tag_mutability = "IMMUTABLE"
}
