provider "aws" {
  region = var.aws_region
}

module "iam" {
  source = "./modules/iam"
}

module "s3" {
  source      = "./modules/s3"
  bucket_name = var.artifact_store_s3_location
}

module "codecommit" {
  source                 = "./modules/codecommit"
  repository_name        = var.repository_name
  repository_description = var.repository_description
}

module "codebuild" {
  source              = "./modules/codebuild"
  project_name        = var.project_name
  project_description = var.project_description
  service_role_arn    = module.iam.codebuild_role_arn
  buildspec           = file("${path.module}/buildspec.yml")
  dsn                 = var.dsn
}

module "codepipeline" {
  source                     = "./modules/codepipeline"
  pipeline_name              = var.pipeline_name
  role_arn                   = module.iam.codepipeline_role_arn
  artifact_store_s3_location = module.s3.bucket_name
  repository_name            = module.codecommit.repository_name
  branch_name                = var.branch_name
  codebuild_project_name     = module.codebuild.codebuild_project_name
}
