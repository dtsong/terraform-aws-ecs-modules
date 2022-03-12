# Dependency variables
variable "s3_bucket_arn" {
  description = "ARN of S3 bucket that needs to be accessed by the ECS task role"
  type        = string
}

# Local variables
variable "ecs_task_role_name" {
  description = "Name of ECS task IAM role"
  type        = string
}

variable "ecs_execution_role_name" {
  description = "Name of ECS execution IAM role"
  type        = string
}

variable "ecs_execution_role_path" {
  description = "ECS Execution IAM Role Path (for easier identification)"
  type        = string
}