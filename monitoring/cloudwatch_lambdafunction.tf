resource "aws_cloudwatch_log_group" "lambda_log_group" {
  count        = length(var.lambda_function_names)
  name         = "/aws/lambda/${element(var.lambda_function_names, count.index)}"
  retention_in_days = 14
}
