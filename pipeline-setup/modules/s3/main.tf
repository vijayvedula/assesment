resource "aws_s3_bucket" "codepipeline_artifacts" {
  bucket = var.bucket_name

  acl = "private"

  versioning {
    enabled = true
  }

  tags = {
    Name        = var.bucket_name
    Environment = "Dev"
  }
}
