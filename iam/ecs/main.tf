# ECS Task Role Resources
data "aws_iam_policy_document" "assume_role_ecs_tasks" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "ecs_task_s3" {
  statement {
    actions   = ["s3:GetObject", "s3:PutObject"]
    resources = [var.s3_bucket_arn]
  }
}

# Combines the above two data IAM policy documents once they are constructed
# Source: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document#example-of-merging-source-documents
data "aws_iam_policy_document" "ecs_task_role_necessary_access" {
  source_policy_documents = [
    data.aws_iam_policy_document.assume_role_ecs_tasks.json,
    data.aws_iam_policy_document.ecs_task_s3.json
  ]
}

resource "aws_iam_role_policy" "ecs_task_s3" {
  name   = "ecs-task-get-push-to-s3"
  role   = aws_iam_role.ecs_task.id
  policy = data.aws_iam_policy_document.ecs_task_s3.json
}

resource "aws_iam_role" "ecs_task" {
  name               = var.ecs_task_role_name
  path               = var.ecs_task_role_path
  assume_role_policy = data.aws_iam_policy_document.assume_role_ecs_tasks.json
}

# ECS Execution Role Resources
data "aws_iam_policy_document" "ecs_execution" {
  statement {
    actions = [
      "ecr:GetAuthorizationToken",
      "ecr:BatchCheckLayerAvailability",
      "ecr:GetDownloadUrlForLayer",
      "ecr:BatchGetImage",
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]

    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }

    # TODO: Figure out what resources need to be executed and pass those ARNs here
    resources = ["*"]
  }
}

data "aws_iam_policy_document" "ecs_task_execution_role_necessary_access" {
  source_policy_documents = [
    data.aws_iam_policy_document.assume_role_ecs_tasks.json,
    data.aws_iam_policy_document.ecs_execution.json
  ]
}

resource "aws_iam_role" "ecs_execution" {
  name               = var.ecs_execution_role_name
  path               = var.ecs_execution_role_path
  assume_role_policy = data.aws_iam_policy_document.assume_role_ecs_tasks.json
}

resource "aws_iam_role_policy" "ecs_execution_iam_policy" {
  name   = "ecs-execution-policy"
  role   = aws_iam_role.ecs_task.id
  policy = data.aws_iam_policy_document.ecs_execution.json
}