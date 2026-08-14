output "deploy_role_arn" {
  description = "Set as AWS_DEPLOY_ROLE_ARN repo variable in GitHub"
  value       = aws_iam_role.github_deploy.arn
}

output "state_bucket" {
  value = aws_s3_bucket.tfstate.id
}
