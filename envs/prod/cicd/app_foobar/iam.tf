resource "aws_iam_user" "github" {
  name = "${local.name_prefix}-${local.service_name}-github"
  
  tags = {
    Name = "${local.name_prefix}-${local.service_name}-github"
  }
}

resource "aws_iam_role" "deployer" {
  name = "${local.name_prefix}-${local.service_name}-deployer"

  assume_role_policy = jsonencode(
    {
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Effect" : "Allow",
          "Action" : [
          "sts:AssumeRole",
          "sts:TagSession"
          ],
          "Principal" : {
            "AWS" : aws_iam_user.github.arn
          }
        }
      ]
    }
  )
  tags = {
    Name = "${local.name_prefix}-${local.service_name}-deployer"
  }
}