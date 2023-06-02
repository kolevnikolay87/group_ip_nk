resource "aws_iam_role" "eventbridge_codebuild_role" {
  name = "eventbridge-codebuild-role"
  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : {
          "Service" : "events.amazonaws.com"
        },
        "Action" : "sts:AssumeRole"
      }
    ]
  })
  tags = {
    name = "eventbridge-codebuild-role"
  }
}

resource "aws_iam_policy_attachment" "eventbridge_codebuild_access_attachment" {
  name       = "Event-bridge-CodeBuild-Acc-mgmt"
  roles      = [aws_iam_role.eventbridge_codebuild_role.id]
  policy_arn = "arn:aws:iam::aws:policy/AWSCodeBuildAdminAccess"
}

resource "aws_cloudwatch_event_rule" "cloud_nuke_rule" {
  name        = "CloudNukeEventRule"
  description = "Event rule to trigger CloudNuke"

  schedule_expression = "cron(0 20 * * ? *)"
}

resource "aws_cloudwatch_event_target" "cloud_nuke_target" {
  rule      = aws_cloudwatch_event_rule.cloud_nuke_rule.name
  target_id = "CloudNukeTarget"
  arn       = aws_codebuild_project.cloud_nuke_project.arn
}