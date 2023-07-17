resource "aws_iam_role" "fog360-c7n-role" {
    name = "fog360-c7n"

    assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = "allow lambda to run role"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      },
    ]
  })

  tags = {
    Name = "fog360-c7n-customer-role"
    Customer = var.supportfog-customername
  }
}