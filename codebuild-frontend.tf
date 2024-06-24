resource "aws_codebuild_project" "frontend_build" {
  name          = "frontend-build"
  service_role  = aws_iam_role.codebuild_role.arn

  artifacts {
    type = "NO_ARTIFACTS"
  }

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/standard:4.0"
    type                        = "LINUX_CONTAINER"
    environment_variable {
      name  = "ENV_VAR"
      value = "value"
    }
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
      - npm run build
EOF
  }

  build_timeout = 60
}
