variable "pipeline_name" {
  description = "The name of the CodePipeline"
  type        = string
}

variable "role_arn" {
  description = "The ARN of the IAM role that CodePipeline will use"
  type        = string
}

variable "artifact_store_s3_location" {
  description = "The S3 bucket location for CodePipeline artifacts"
  type        = string
}

variable "repository_name" {
  description = "The name of the CodeCommit repository"
  type        = string
}

variable "branch_name" {
  description = "The branch name of the CodeCommit repository"
  type        = string
}

variable "codebuild_project_name" {
  description = "The name of the CodeBuild project"
  type        = string
}
