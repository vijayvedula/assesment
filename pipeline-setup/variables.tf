variable "aws_region" {
  description = "AWS region"
  default     = "us-west-2"
}

variable "repository_name" {
  description = "The name of the CodeCommit repository"
  type        = string
  default     = "student-registration-repo"
}

variable "repository_description" {
  description = "The description of the CodeCommit repository"
  type        = string
  default     = "Repository for student registration application"
}

variable "project_name" {
  description = "The name of the CodeBuild project"
  type        = string
  default     = "student-registration-build"
}

variable "project_description" {
  description = "The description of the CodeBuild project"
  type        = string
  default     = "Build project for student registration application"
}

variable "pipeline_name" {
  description = "The name of the CodePipeline"
  type        = string
  default     = "student-registration-pipeline"
}

variable "artifact_store_s3_location" {
  description = "The S3 bucket location for CodePipeline artifacts"
  type        = string
  default     = "my-unique-codepipeline-artifacts-bucket-123456"
}


variable "branch_name" {
  description = "The branch name of the CodeCommit repository"
  type        = string
  default     = "main"
}

variable "dsn" {
  description = "The DSN for the database"
  type        = string
  sensitive   = true
  default     = "host=mydatabase.cv8a6qycwhd9.us-west-2.rds.amazonaws.com user=myusername password=mypassword dbname=mydatabase port=5432 sslmode=disable"
}

variable "codepipeline_role_arn" {
  description = "The ARN of the IAM role that CodePipeline will use"
  type        = string
}

variable "codebuild_role_arn" {
  description = "The ARN of the IAM role that CodeBuild will use"
  type        = string
}

