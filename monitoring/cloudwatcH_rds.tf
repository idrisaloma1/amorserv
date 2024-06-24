resource "aws_cloudwatch_metric_alarm" "rds_cpu_utilization" {
  alarm_name           = "RDS_CPU_Utilization"
  comparison_operator  = "GreaterThanThreshold"
  evaluation_periods   = 1
  metric_name          = "CPUUtilization"
  namespace            = "AWS/RDS"
  period               = 300
  statistic            = "Average"
  threshold            = 80 # Adjust this threshold based on your application's requirements
  alarm_description    = "Alarm for RDS instance CPU utilization"
  dimensions = {
    DBInstanceIdentifier = var.rds_instance_identifier
  }
  alarm_actions        = [aws_sns_topic.cloudwatch_alarm_topic.arn]
}

resource "aws_cloudwatch_metric_alarm" "rds_free_storage_space" {
  alarm_name           = "RDS_Free_Storage_Space"
  comparison_operator  = "LessThanThreshold"
  evaluation_periods   = 1
  metric_name          = "FreeStorageSpace"
  namespace            = "AWS/RDS"
  period               = 300
  statistic            = "Average"
  threshold            = 10000000000 # 10 GB, adjust this threshold based on your application's requirements
  alarm_description    = "Alarm for RDS instance free storage space"
  dimensions = {
    DBInstanceIdentifier = var.rds_instance_identifier
  }
  alarm_actions        = [aws_sns_topic.cloudwatch_alarm_topic.arn]
}
