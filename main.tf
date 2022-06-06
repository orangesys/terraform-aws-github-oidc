data "aws_iam_policy_document" "iodc-assume-role-policy" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]

    principals {
      type        = "Federated"
      identifiers = [
          var.openid_connect_provider_arn
        ]
    }
  }
}

resource "aws_iam_role" "github_oidc_role_policy" {
  name               = "github-action-aws-admin"
  assume_role_policy = data.aws_iam_policy_document.iodc-assume-role-policy.json
}

resource "aws_iam_role_policy_attachment" "github_oidc_role_attachment" {
  policy_arn = "arn:aws:iam::aws:policy/job-function/SystemAdministrator"
  role       = aws_iam_role.github_oidc_role_policy.id
}