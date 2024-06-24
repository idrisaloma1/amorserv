# main.tf

resource "aws_amplify_app" "amorserv_amplify_app" {
  name       = "amorserv_amplify_app"
  repository = "https://github.com/idrisaloma1/amorserv.git" # Replace with your GitHub repo
  oauth_token = var.github_token # Ensure this token has proper permissions

  environment_variables = {
    RDS_HOSTNAME = aws_db_instance.amorserv_rds.address
    RDS_USERNAME = "admin"
    RDS_PASSWORD = "password"
  }
}

resource "aws_amplify_branch" "amorserv_branch" {
  app_id      = aws_amplify_app.amorserv_amplify_app.id
  branch_name = "amorserv"
}
/**
variable "github_repo" {
  type    = string
  default = "https://github.com/idrisaloma1/amorserv.git"
}

variable "github_token" {
  type    = string
  default = ""
}
**/
