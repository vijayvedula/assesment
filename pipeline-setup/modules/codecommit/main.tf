resource "aws_codecommit_repository" "repo" {
  repository_name = var.repository_name
  description     = var.repository_description
}

output "repository_clone_url_http" {
  value = aws_codecommit_repository.repo.clone_url_http
}

output "repository_clone_url_ssh" {
  value = aws_codecommit_repository.repo.clone_url_ssh
}
