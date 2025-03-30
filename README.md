# AWS CI/CD Pipeline with ECS Deployment

## Overview
This architecture represents a CI/CD pipeline for deploying containerized applications to AWS ECS using AWS CodePipeline, CodeBuild, and CodeDeploy. The process starts from a developer pushing code to a Git repository, which triggers an automated pipeline to build, test, and deploy the application.

## Architecture Components

### 1. **Developer**
   - Pushes code to the Git repository, which triggers the CI/CD pipeline.

### 2. **Git Repository (GitHub/CodeCommit)**
   - Stores the source code of the application.
   - Acts as the trigger point for the pipeline when a new commit is pushed.

### 3. **AWS CodePipeline**
   - Automates the build and deployment process.
   - Consists of stages: Source, Build, and Deploy.

### 4. **AWS CodeBuild**
   - Builds the application code.
   - Generates a container image and pushes it to Amazon Elastic Container Registry (ECR).
   - Creates the ECS task definition for deployment.

### 5. **Amazon ECR (Elastic Container Registry)**
   - Stores Docker images that are used for deployment in ECS.

### 6. **Amazon ECS (Elastic Container Service)**
   - Orchestrates and runs the containerized application.
   - Uses Fargate or EC2 as the underlying infrastructure.

### 7. **AWS CodeDeploy**
   - Deploys the new ECS task definition to ECS services.
   - Ensures zero-downtime deployment.

### 8. **Amazon S3**
   - Stores configuration files such as `appsec.yaml` for security configurations.

### 9. **Application Load Balancer (ALB)**
   - Routes traffic to ECS tasks running in Amazon ECS.
   - Provides high availability and scalability.

### 10. **End User**
   - Accesses the application through the Application Load Balancer.

## Workflow
1. Developer pushes code to GitHub.
2. AWS CodePipeline is triggered and fetches the latest code.
3. AWS CodeBuild builds the application, creates a Docker image, and pushes it to Amazon ECR.
4. CodeBuild updates the ECS task definition.
5. The new task definition is deployed to ECS using AWS CodeDeploy.
6. ECS tasks are updated with the new container version and are exposed through the Application Load Balancer.
7. End users access the updated application through ALB.

## Prerequisites
- AWS account with IAM permissions for CodePipeline, CodeBuild, CodeDeploy, ECS, ECR, and S3.
- GitHub repository with source code and necessary build files (e.g., Dockerfile, buildspec.yml).
- An ECS cluster and service configured to run the application.
- Application Load Balancer set up for traffic routing.

## Deployment Steps
1. **Setup Git Repository**
   - Push your application code to GitHub.

2. **Configure AWS CodePipeline**
   - Create a pipeline with source, build, and deploy stages.

3. **Setup AWS CodeBuild**
   - Define `buildspec.yml` to build and push Docker images to Amazon ECR.

4. **Deploy Application**
   - CodeDeploy updates ECS services with the new task definition.

5. **Access Application**
   - Navigate to the ALB DNS to verify the deployment.

## Architecture Diagram
<img width="837" alt="Screenshot 2025-03-30 at 10 52 50 PM" src="https://github.com/user-attachments/assets/621b4ff4-2204-4e2d-9c73-1c86e1e5c9ff" />


## Conclusion
This CI/CD pipeline automates the deployment of containerized applications to AWS ECS, ensuring scalability, security, and high availability with minimal manual intervention. By leveraging AWS CodePipeline, CodeBuild, and CodeDeploy, developers can achieve continuous integration and deployment with ease.
