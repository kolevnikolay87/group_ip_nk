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