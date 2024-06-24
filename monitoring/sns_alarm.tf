resource "aws_sns_topic" "cloudwatch_alarm_topic" {
  name = "cloudwatch_alarm_topic"
}

resource "aws_sns_topic_subscription" "alarm_email_subscription" {
  topic_arn = aws_sns_topic.cloudwatch_alarm_topic.arn
  protocol  = "email"
  endpoint  = var.alarm_email
}
