output "aws_oidc_arn" {
  value = aws_iam_role.github_oidc_role_policy.arn
}