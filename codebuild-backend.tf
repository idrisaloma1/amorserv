resource "aws_codebuild_project" "backend_build" {
  name          = "backend-build"
  service_role  = aws_iam_role.codebuild_role.arn

  artifacts {
    type = "NO_ARTIFACTS"
  }

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/standard:4.0"
    type                        = "LINUX_CONTAINER"
  }

  source {
    type            = "GITHUB"
    location        = var.github_repo
    git_clone_depth = 1
    buildspec       = <<EOF
version: 0.2

phases:
  install:
    commands:
      - npm install
  build:
    commands:
      - zip -r lambda.zip *
      - aws s3 cp lambda.zip s3://${aws_s3_bucket_acl.amarserv-codepipeline-bucket.bucket}/
EOF
  }

  build_timeout = 60
}
