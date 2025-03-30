# Terraform configuration for AWS CodePipeline, CodeBuild, CodeDeploy to ECS Environment

# IAM Role for CodeBuild
resource "aws_iam_role" "codebuild_role" {
  name = "codebuild-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "codebuild.amazonaws.com"
      }
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_policy" "codebuild_policy" {
  name        = "codebuild-policy"
  description = "Permissions for AWS CodeBuild"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "s3:GetObject",
          "s3:PutObject",
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents",
          "ecr:BatchCheckLayerAvailability",
          "ecr:CompleteLayerUpload",
          "ecr:GetAuthorizationToken",
          "ecr:InitiateLayerUpload",
          "ecr:PutImage",
          "ecr:UploadLayerPart"
        ]
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "codebuild_policy_attach" {
  role       = aws_iam_role.codebuild_role.name
  policy_arn = aws_iam_policy.codebuild_policy.arn
}


# code buildbuild
module "codde_build" {
  source           = "../../tf-modules/codebuild"
  project_name     = var.project_name
  service_role_arn = aws_iam_role.codebuild_role.arn
  github_repo_url  = var.github_repo_url
  build_env_variables = {
    AWS_DEFAULT_REGION = data.aws_region.current.name
    AWS_ACCOUNT_ID     = data.aws_caller_identity.current.account_id
    IMAGE_REPO_NAME    = var.ecr_repo_name
  }
  depends_on = [module.ecr_repo]
}
module "ecr_repo" {
  source        = "../../tf-modules/ecr"
  ecr_repo_name = var.ecr_repo_name
}