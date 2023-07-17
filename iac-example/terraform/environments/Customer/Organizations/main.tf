resource "aws_iam_role" "fog360-c7n" {
  name = "fog360-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          "Resource": var.supportfog-customer-arn
        }
      },
    ]
  })
}


data "aws_iam_role_policy" "fog360-c7n-policy" {
  name = "fog360 c7n role policy"
  role = aws_iam_role.fog360-c7n.id
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "NotAction" : [
          "iam:*",
          "organizations:*",
          "account:*"
        ],
        "Resource" : "*"
      },
      {
        "Effect" : "Allow",
        "Action" : [
          "iam:CreateServiceLinkedRole",
          "iam:DeleteServiceLinkedRole",
          "iam:ListRoles",
          "organizations:DescribeOrganization",
          "account:ListRegions",
          "account:GetAccountInformation"
        ],
        "Resource" : "*"
      }
    ]
  })
}

