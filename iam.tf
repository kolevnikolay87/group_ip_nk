resource "aws_iam_role" "eventbridge_codebuild_role" {
  name = "eventbridge-codebuild-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
  tags = {
    name = "eventbridge-codebuild-role"
  }
}

resource "aws_iam_policy_attachment" "eventbridge_codebuild_access_attachment" {
  role = aws_iam_role.eventbridge_codebuild_role.id
  policy_arn = "arn:aws:iam::aws:policy/AWSCodeBuildAdminAccess"
}