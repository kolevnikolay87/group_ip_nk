<<<<<<< HEAD
variable "aws_region" {
  description = "AWS region where the resources will be created."
  type        = string
  default     = "eu-west-1"
}

variable "docker_image" {
  type = string
  default = "aws/codebuild/amazonlinux2-x86_64-standard:3.0"
}

variable "type_of_build" {
  type = string
  default = "LINUX_CONTAINER"
}

variable "compute_type" {
  type = string
  default = "BUILD_GENERAL1_SMALL"
}

variable "type_of_artifacts" {
  type = string
  default = "NO_ARTIFACTS"
}
=======
variable "schedule_expression" {
  type = string
  description = "cronjob schedule expression"
  default = "cron(0 20 * * ? *)"
}
>>>>>>> e6ad702 (adjusted iam.tf, added schedule_expression variable and adjusted role + attachment)
