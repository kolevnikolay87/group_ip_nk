variable "schedule_expression" {
  type = string
  description = "cronjob schedule expression"
  default = "cron(0 20 * * ? *)"
}