variable "project_name" {
  description = "The name of the CodeBuild project"
  type        = string
}

variable "project_description" {
  description = "The description of the CodeBuild project"
  type        = string
}

variable "service_role_arn" {
  description = "The ARN of the service role that CodeBuild will use"
  type        = string
}

variable "buildspec" {
  description = "The buildspec file for CodeBuild"
  type        = string
}

variable "dsn" {
  description = "The DSN for the database"
  type        = string
  sensitive   = true
}
