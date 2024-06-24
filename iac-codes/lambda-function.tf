# main.tf

resource "aws_lambda_function" "armorserv_lambda" {
  filename         = "lambda_function_payload.zip" # Ensure your Lambda code is zipped and uploaded here
  function_name    = "armorservLambdaFunction"
  role             = aws_iam_role.lambda_exec_role.arn
  handler          = "index.handler"
  runtime          = "nodejs20.x"

  environment {
    variables = {
      RDS_HOSTNAME = aws_db_instance.amorserv_rds.address
      RDS_USERNAME = "admin"
      RDS_PASSWORD = "password"
    }
  }
}
