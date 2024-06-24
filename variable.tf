variable "github_repo" {
  type    = string
  default = "https://github.com/idrisaloma1/amorserv.git"
}

variable "github_token" {
  type    = string
  default = ""
}

variable "s3_bucket_name" {
  type    = string
  default = "codepipeline-bucket"
}
