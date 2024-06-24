resource "aws_s3_bucket_acl" "amarserv-codepipeline-bucket" {
  bucket = "codepipeline-bucket"
  acl    = "private"
  #region = "us-west-2"
  
}

/** 
resource "aws_s3_bucket" "code-pipeline-1" {
  bucket = "code-pipeline-bucket"
}

resource "aws_s3_bucket_ownership_controls" "code-pipeline-1" {
  bucket = aws_s3_bucket.code-pipeline-1.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_acl" "codepipeline_bucket" {
  depends_on = [aws_s3_bucket_ownership_controls.code-pipeline]

  bucket = aws_s3_bucket.code-pipeline-1.id
  acl    = "private"
}
**/