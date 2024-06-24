resource "aws_cloudwatch_metric_alarm" "lambda_invocation_errors" {
  count                = length(var.lambda_function_names)
  alarm_name           = "${element(var.lambda_function_names, count.index)}_invocation_errors"
  comparison_operator  = "GreaterThanThreshold"
  evaluation_periods   = 1
  metric_name          = "Errors"
  namespace            = "AWS/Lambda"
  period               = 300
  statistic            = "Sum"
  threshold            = 1
  alarm_description    = "Alarm for Lambda function invocation errors"
  dimensions = {
    FunctionName = element(var.lambda_function_names, count.index)
  }
  alarm_actions        = [aws_sns_topic.cloudwatch_alarm_topic.arn]
}

resource "aws_cloudwatch_metric_alarm" "lambda_duration" {
  count                = length(var.lambda_function_names)
  alarm_name           = "${element(var.lambda_function_names, count.index)}_duration"
  comparison_operator  = "GreaterThanThreshold"
  evaluation_periods   = 1
  metric_name          = "Duration"
  namespace            = "AWS/Lambda"
  period               = 300
  statistic            = "Average"
  threshold            = 5000 # Adjust this threshold based on your application's requirements
  alarm_description    = "Alarm for Lambda function duration"
  dimensions = {
    FunctionName = element(var.lambda_function_names, count.index)
  }
  alarm_actions        = [aws_sns_topic.cloudwatch_alarm_topic.arn]
}
