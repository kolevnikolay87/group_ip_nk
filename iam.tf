resource "aws_iam_role" "eventbridge_role" {
  name = "eventbridge-role-2"
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
}

resource "aws_iam_role" "codebuild_role" {
  name = "codebuild-role-2"
  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : {
          "Service" : "codebuild.amazonaws.com"
        },
        "Action" : "sts:AssumeRole"
      }
    ]
  })
}

data "aws_iam_policy_document" "FullAdmin" {
  statement {
    actions = ["*"]
    effect = "Allow"
    resources = ["*"]
  }
}

resource "aws_iam_policy" "FullAdmin" {
  name   = "example_policy"
  path   = "/"
  policy = data.aws_iam_policy_document.FullAdmin.json
}
resource "aws_iam_policy_attachment" "eventbridge_codebuild_access_attachment" {
  name       = "Event-bridge-CodeBuild-Acc-mgmt"
  roles      = [aws_iam_role.eventbridge_role.id]
  policy_arn = aws_iam_policy.FullAdmin.arn
}


resource "aws_iam_policy_attachment" "codebuild_access_attachment" {
  name       = "Event-bridge-CodeBuild-Acc-mgmt"
  roles      = [aws_iam_role.codebuild_role.id]
  policy_arn = aws_iam_policy.FullAdmin.arn
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
  role_arn = aws_iam_role.eventbridge_role.arn
}
