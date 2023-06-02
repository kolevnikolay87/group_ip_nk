<<<<<<< HEAD
resource "aws_codebuild_project" "cloud_nuke_project" {
  name          = "CloudNukeProject"
  description   = "CodeBuild project to execute CloudNuke"
  service_role  = aws_iam_role.codebuild.arn
  build_timeout = 60

  artifacts {
    type = var.type_of_artifacts
  }

  environment {
    compute_type                = var.compute_type
    image                       = var.docker_image
    type                        = var.type_of_build
    privileged_mode             = false
    environment_variable {
      name  = "REGION"
      value = var.aws_region
    }
  }

  source {
    type            = "NO_SOURCE"
    buildspec       = file("${cloud_nuke.yaml}")
    report_build_status = false
  }
}
=======
resource "aws_cloudwatch_event_rule" "codebuild" {
  name        = "trigger-eventbridge-codebuild"
  description = "Trigger a codebiuld"
  account = "790184663615"
  role_arn = aws_iam_role.eventbridge_codebuild_role.arn

  event_pattern = jsonencode({
    detail-type = [
      "AWS Console Sign In via CloudTrail"
    ]
  })
  schedule_expression = var.schedule_expression
}
>>>>>>> e6ad702 (adjusted iam.tf, added schedule_expression variable and adjusted role + attachment)
