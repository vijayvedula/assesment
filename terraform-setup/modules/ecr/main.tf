resource "aws_ecr_repository" "main" {
  name = "student-registration-backend"
}

output "repository_url" {
  value = aws_ecr_repository.main.repository_url
}
