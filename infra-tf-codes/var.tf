# codebuild
variable "project_name" {
  description = "Name of the CodeBuild project"
  type        = string
}
variable "github_repo_url" {
  description = "URL of the GitHub repository"
  type        = string
}
variable "ecr_repo_name" {
  description = "Name of the ECR repository"
  type        = string
}