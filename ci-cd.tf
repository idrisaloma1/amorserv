resource "aws_codepipeline" "cicd_pipeline" {
  name     = "cicd-pipeline"
  role_arn = aws_iam_role.codepipeline_role.arn

  artifact_store {
    type     = "S3"
    location = aws_s3_bucket_acl.amarserv-codepipeline-bucket.bucket
  }

  stage {
    name = "Source"

    action {
      name             = "Source"
      category         = "Source"
      owner            = "ThirdParty"
      provider         = "GitHub"
      version          = "1"
      output_artifacts = ["source_output"]
      configuration = {
        Owner  = "your-github-username"
        Repo   = "your-repo-name"
        Branch = "main"
        OAuthToken = var.github_token
      }
    }
  }

  stage {
    name = "Build"

    action {
      name             = "FrontendBuild"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      version          = "1"
      input_artifacts  = ["source_output"]
      output_artifacts = ["frontend_build_output"]
      configuration = {
        ProjectName = aws_codebuild_project.frontend_build.name
      }
    }

    action {
      name             = "BackendBuild"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      version          = "1"
      input_artifacts  = ["source_output"]
      output_artifacts = ["backend_build_output"]
      configuration = {
        ProjectName = aws_codebuild_project.backend_build.name
      }
    }
  }

  stage {
    name = "Deploy"

    action {
      name        = "DeployFrontend"
      category    = "Deploy"
      owner       = "AWS"
      provider    = "Amplify"
      version          = "1"
      input_artifacts = ["frontend_build_output"]
      configuration = {
        AppId    = aws_amplify_app.amorserv_amplify_app.id
        BranchName = aws_amplify_branch.amorserv_branch.branch_name
      }
    }

    action {
      name        = "DeployBackend"
      category    = "Deploy"
      owner       = "AWS"
      provider    = "Lambda"
      version          = "1"
      input_artifacts = ["backend_build_output"]
      configuration = {
        FunctionName = aws_lambda_function.armorserv_lambda.function_name
        S3Bucket     = aws_s3_bucket_acl.amarserv-codepipeline-bucket.bucket
        S3Key        = "lambda.zip"
      }
    }
  }
}
