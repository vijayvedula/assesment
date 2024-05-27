resource "aws_codebuild_project" "build" {
  name          = var.project_name
  description   = var.project_description
  service_role  = var.service_role_arn

  artifacts {
    type = "CODEPIPELINE"
  }

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/standard:4.0"
    type                        = "LINUX_CONTAINER"
    environment_variable {
      name  = "DSN"
      value = var.dsn
    }
  }

  source {
    type      = "CODEPIPELINE"
    buildspec = var.buildspec
  }
}

output "codebuild_project_name" {
  value = aws_codebuild_project.build.name
}
