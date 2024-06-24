variable "lambda_function_names" {
  description = "List of Lambda function names to monitor"
  type        = list(string)
}

variable "rds_instance_identifier" {
  description = "Identifier of the RDS instance to monitor"
  type        = string
}

variable "alarm_email" {
  description = "Email address to send CloudWatch alarms"
  type        = string
}
